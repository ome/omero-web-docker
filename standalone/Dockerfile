ARG PARENT_IMAGE=openmicroscopy/omero-web:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN /opt/omero/web/venv3/bin/pip install \
        omero-figure==6.2.0 \
        omero-iviewer==0.13.0 \
        omero-fpbioimage==0.4.1 \
        omero-mapr==0.5.2 \
        omero-parade==0.2.4 \
        omero-autotag==0.4.1 \
        omero-tagsearch==0.4.1 \
        whitenoise==6.6.0

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
