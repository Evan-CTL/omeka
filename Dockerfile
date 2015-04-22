FROM erochest/omeka
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

## I'm not sure this is the correct way to do this
# make sure imagemagick is installed
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install imagemagick

# our plugins
COPY ./files/plugins/CSSEditor /app/plugins/CSSEditor
COPY ./files/plugins/Coins /app/plugins/Coins
COPY ./files/plugins/Commenting /app/plugins/Commenting
COPY ./files/plugins/CsvImport /app/plugins/CsvImport
COPY ./files/plugins/DocsViewer /app/plugins/DocsViewer
COPY ./files/plugins/ExhibitBuilder /app/plugins/ExhibitBuilder
COPY ./files/plugins/GoogleAnalytics /app/plugins/GoogleAnalytics
COPY ./files/plugins/HideElements /app/plugins/HideElements
COPY ./files/plugins/Html5Media /app/plugins/Html5Media
COPY ./files/plugins/ItemOrder /app/plugins/ItemOrder
COPY ./files/plugins/Neatline /app/plugins/Neatline
COPY ./files/plugins/NeatlineText /app/plugins/NeatlineText
COPY ./files/plugins/OmekaApiImport /app/plugins/OmekaApiImport
COPY ./files/plugins/PdfEmbed /app/plugins/PdfEmbed
COPY ./files/plugins/ShortcodeCarousel /app/plugins/ShortcodeCarousel
COPY ./files/plugins/SimplePages /app/plugins/SimplePages

EXPOSE 80
CMD ["/run.sh"]
