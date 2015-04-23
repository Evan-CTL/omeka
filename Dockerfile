FROM erochest/omeka
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install imagemagick

COPY ./files/plugins/* /app/plugins/

EXPOSE 80
CMD ["/run.sh"]
