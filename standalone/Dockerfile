ARG PARENT_IMAGE=openmicroscopy/omero-web:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN /opt/omero/web/venv3/bin/pip install \
        omero-figure \
        omero-iviewer \
        omero-fpbioimage \
        omero-mapr \
        omero-parade \
        omero-webtagging-autotag \
        omero-webtagging-tagsearch \
        whitenoise

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
