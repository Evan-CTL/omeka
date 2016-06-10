
FROM tutum/apache-php:latest
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

# adapted from https://github.com/erochest/docker-omeka/blob/master/Dockerfile

# RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
#RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install imagemagick
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install apache2

RUN a2enmod rewrite

COPY ./files/omeka-2.4.1/ /app/
RUN chmod -R a+rwx /app/files

COPY ./files/db.ini /app/db.ini
COPY ./files/application/config/config.ini /app/application/config/config.ini
COPY ./files/plugins/ /app/plugins/
COPY ./files/htaccess /app/.htaccess
COPY ./files/000-default.conf /etc/apache2/sites-available/000-default.conf
# address imagemagick vulnerability
COPY ./files/imagemagick-policy.xml /etc/ImageMagick/policy.xml

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
