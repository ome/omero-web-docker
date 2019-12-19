ARG PARENT_IMAGE=openmicroscopy/omero-web-standalone:latest
FROM ${PARENT_IMAGE}
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

USER root

RUN yum install -y -q \
    java-1.8.0-openjdk \
    patch \
    redhat-lsb-core \
    rsync \
    tar \
    unzip \
    wget \
    zip \
    && yum clean all

USER omero-web
