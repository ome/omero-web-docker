ARG PARENT_IMAGE=openmicroscopy/omero-web:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN /opt/omero/web/venv3/bin/pip install \
        django-cors-headers \
        'omero-figure>=4.2.dev1' \
        'omero-iviewer>=0.9.0.dev1' \
        'whitenoise'

        #omero-fpbioimage \
        #omero-mapr \
        #omero-parade \
        #omero-webtagging-autotag \
        #omero-webtagging-tagsearch \

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
