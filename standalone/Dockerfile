FROM openmicroscopy/omero-web:latest
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN yum install -y -q \
        python-markdown \
        python-reportlab && \
    /opt/omero/web/venv/bin/pip install \
        django-cors-headers \
        omero-figure \
        omero-fpbioimage \
        omero-iviewer \
        omero-mapr \
        omero-parade \
        omero-webtagging-autotag \
        omero-webtagging-tagsearch \
        'whitenoise<4'

ADD default-webapps.omero /opt/omero/web/config/

USER omero-web
