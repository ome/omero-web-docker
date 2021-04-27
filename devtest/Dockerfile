ARG PARENT_IMAGE=openmicroscopy/omero-web-standalone:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN yum install -y -q \
    java-11-openjdk \
    patch \
    redhat-lsb-core \
    rsync \
    tar \
    unzip \
    wget \
    zip

# Shouldn't be necessary any more since OMERO.web/bin/omero is a Python script but included anyway from previous image used in https://github.com/ome/omero-test-infra
RUN rm /opt/omero/web/OMERO.web/bin/omero && ln -s /opt/omero/web/venv3/bin/omero /opt/omero/web/OMERO.web/bin/omero

USER omero-web
