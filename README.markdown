CCNMTL's customized Omeka container

This builds off of `erochest/omeka` and adds our basic set of
plugins.

This omeka container needs to be linked to a postfix container and a storage container, and optionally, a mysql container (unless it is set up to connect to a non-docker mysql database).

It can be started with a command similar to the following:

  /usr/bin/docker run \
     -p 8880:80 \
     --volumes-from=omeka-data \
     --link mysql:mysql \
     --link postfix:postfix \
     localhost:5000/ccnmtl/omeka

Where, omeka-data is simply

  /usr/bin/docker run \
     --name=omeka-data \
     -v /var/local/docker/data/omeka-files:/app/files \
     -v /app/files \
     localhost:5000/ccnmtl/omeka \
     /bin/echo I am a data only container