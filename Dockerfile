FROM erochest/omeka
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

## I'm not sure this is the correct way to do this
# make sure imagemagick is installed
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install imagemagick

# our plugins
COPY ./files/plugins/* /app/plugins/

EXPOSE 80
CMD ["/run.sh"]
