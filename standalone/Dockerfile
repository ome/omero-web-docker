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

RUN echo "config append -- omero.web.middleware '{\"index\": 0, \"class\": \"whitenoise.middleware.WhiteNoiseMiddleware\"}'" > /opt/omero/web/config/whitenoise.omero

USER omero-web
