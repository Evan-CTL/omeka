// Sandbox approvals that you will need (at least):
// staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods plus java.lang.Object[]
// staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods getAt java.lang.Iterable int
// java.lang.Object[]
// staticMethod org.codehaus.groovy.runtime.DefaultGroovyMethods plus java.util.List java.lang.Object

TAG = 'build-' + env.BUILD_NUMBER
env.TAG = TAG

// check for required parameters. assign them to the env for
// convenience and make sure that an exception is raised if any
// are missing as a side-effect

env.APP = APP
env.REPO = REPO
env.ADMIN_EMAIL = ADMIN_EMAIL

def staging_hosts = STAGING_HOSTS.split(" ")
def prod_hosts = PROD_HOSTS.split(" ")

def mediacheckURLStaging = null
try {
    mediacheckURLStaging = MEDIACHECK_URL_STAGING
} catch (mediacheckURLStagingError) {
    mediacheckURLStaging = "https://${APP}.stage.ctl.columbia.edu/"
}

def mediacheckURLProd = null
try {
    mediacheckURLProd = MEDIACHECK_URL_PROD
} catch (mediacheckURLProdError) {
    mediacheckURLProd = "https://slaveryexhibits.ctl.columbia.edu/"
}

def mediacheckTimeout = 10
try {
    mediacheckTimeout = MEDIACHECK_TIMEOUT
} catch (mediacheckTimeoutError) {
    mediacheckTimeout = 10
}

def mediacheckVerify = ''
try {
    if (MEDIACHECK_SKIP_VERIFY) {
        mediacheckVerify = '--verify-ssl=false'
    }
} catch (mediacheckVerifyError) {
}

def err = null
currentBuild.result = "SUCCESS"

def cwd() {
    def array = pwd().split("/")
    return array[array.length - 2];
}

try {
    node {
        stage 'Checkout'
        checkout scm
    }

    node {
        def branches = [:]
        stage "Sync and Docker Build (staging)"

        for (int i = 0; i < staging_hosts.size(); i++) {
            branches["pull-${i}"] = create_pull_exec(i, staging_hosts[i])
        }
        parallel branches
    }

    node {
        stage "Restart Service (staging)"
        def branches = [:]
        for (int i = 0; i < staging_hosts.size(); i++) {
            branches["web-restart-${i}"] = create_restart_web_exec(i, staging_hosts[i])
        }
        parallel branches
    }

    node {
        if (mediacheckURLStaging != null) {
            stage "mediacheck (staging)"
            //retry_backoff(5) { sh "mediacheck --url='${mediacheckURLStaging}' --log-level=info --timeout=${mediacheckTimeout * 1000} ${mediacheckVerify}" }
        }
    }

    node {
        def branches = [:]
        stage "Docker Pull (prod)"

        for (int i = 0; i < prod_hosts.size(); i++) {
            branches["pull-${i}"] = create_pull_exec(i, prod_hosts[i])
        }
        parallel branches
    }

    node {
        stage "Restart Service (prod)"
        def branches = [:]
        for (int i = 0; i < prod_hosts.size(); i++) {
            branches["web-restart-${i}"] = create_restart_web_exec(i, prod_hosts[i])
        }
        parallel branches
    }

    node {
        if (mediacheckURLProd != null) {
            stage "mediacheck (prod)"
            // retry_backoff(5) { sh "mediacheck --url='${mediacheckURLProd}' --log-level=info --timeout=${mediacheckTimeout * 1000} ${mediacheckVerify}" }
        }
    }

} catch (caughtError) {
    err = caughtError
    currentBuild.result = "FAILURE"
} finally {
    (currentBuild.result != "ABORTED") && node {
        notifyBuild(currentBuild.result)
    }

    /* Must re-throw exception to propagate error */
        if (err) {
        throw err
    }
}

// -------------------- helper functions ----------------------

def notifyBuild(String buildStatus = 'STARTED') {
    // build status of null means successful
    buildStatus =  buildStatus ?: 'SUCCESS'

    // Default values
    def colorCode = '#FF0000'
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def summary = "${subject} (${env.BUILD_URL})"
    def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

    // Override default values based on build status
    if (buildStatus == 'STARTED') {
        color = 'YELLOW'
        colorCode = '#FFFF00'
    } else if (buildStatus == 'SUCCESS') {
        color = 'GREEN'
        colorCode = '#36a64f'
    } else {
        color = 'RED'
        colorCode = '#FF0000'
    }

    // Send notifications
    //  slackSend (color: colorCode, message: summary)

    step([$class: 'Mailer',
            notifyEveryUnstableBuild: true,
            recipients: ADMIN_EMAIL,
            sendToIndividuals: true])
}

def create_pull_exec(int i, String host) {
    cmd = {
        node {
            def cwd = cwd()
            sh """
rsync -azC -v /home/pusher/.jenkins/jobs/slavery/workspace/ ${host}:/var/www/${APP}
ssh ${host} "docker build -t \${REPOSITORY}\$REPO/${APP}:\$TAG /var/www/${APP}/."
            ssh ${host} cp /var/www/${APP}/TAG /var/www/${APP}/REVERT || true
ssh ${host} "echo \$TAG > /var/www/${APP}/TAG"
            ssh ${host} cp /var/www/${APP}/.env /var/www/${APP}/.env_revert || true
ssh ${host} "echo TAG=\$TAG > /var/www/${APP}/.env"
"""
        }
    }
    return cmd
}

def create_restart_web_exec(int i, String host) {
    cmd = {
        node {
            sh """
ssh ${host} sudo /usr/sbin/service ${APP} stop || true
ssh ${host} sudo /usr/sbin/service ${APP} start
"""
        }
    }
    return cmd
}

// retry with exponential backoff
def retry_backoff(int max_attempts, Closure c) {
    int n = 0
    while (n < max_attempts) {
        try {
            c()
            return
        } catch (err) {
            if ((n + 1) >= max_attempts) {
                // we're done. re-raise the exception
                throw err
            }
            sleep(2**n)
            n++
            }
    }
    return
}
