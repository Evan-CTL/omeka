build-local:
	docker build -t ccnmtl/omeka .

run-local:
	docker run -it --rm \
     	-p 8880:80 \
     	--link mysql:mysql \
     	--link postfix:postfix \
	-e MYSQL_USER=omeka \
	-e MYSQL_PASSWORD=omeka \
	-e MYSQL_DBNAME=omeka \
     	ccnmtl/omeka
	# --volumes-from=omeka-data  - don't use volumes on osx, cause perms are broken - https://github.com/boot2docker/boot2docker/issues/581

mysql-shell:
	docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$$MYSQL_PORT_3306_TCP_ADDR" -P"$$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'

build:
	docker build -t localhost:5000/ccnmtl/omeka .

push:
	docker push localhost:5000/ccnmtl/omeka

pull:
	docker pull localhost:5000/ccnmtl/omeka
