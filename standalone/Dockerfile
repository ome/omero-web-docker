FROM openmicroscopy/omero-web:latest
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root
RUN /opt/omero/web/venv/bin/pip install whitenoise==3.3.1 && \
    echo "config append -- omero.web.middleware '{\"index\": 0, \"class\": \"whitenoise.middleware.WhiteNoiseMiddleware\"}'" > /opt/omero/web/config/whitenoise.omero
USER omero-web
