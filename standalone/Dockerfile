ARG PARENT_IMAGE=openmicroscopy/omero-web:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN /opt/omero/web/venv/bin/pip install \
        django-cors-headers==2.4.1 \
        omero-figure \
        omero-fpbioimage \
        omero-iviewer \
        omero-mapr \
        omero-parade \
        omero-webtagging-autotag \
        omero-webtagging-tagsearch \
        'whitenoise<4'

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
