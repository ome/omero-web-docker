FROM centos:centos7
LABEL maintainer="ome-devel@lists.openmicroscopy.org.uk"
LABEL org.opencontainers.image.created="unknown"
LABEL org.opencontainers.image.revision="unknown"
LABEL org.opencontainers.image.source="https://github.com/ome/omero-web-docker"


RUN mkdir /opt/setup
WORKDIR /opt/setup
ADD playbook.yml requirements.yml /opt/setup/

RUN yum -y install epel-release \
    && yum -y install ansible sudo \
    && ansible-galaxy install -p /opt/setup/roles -r requirements.yml

ARG OMERO_VERSION=5.6.0-m1
ARG OMEGO_ADDITIONAL_ARGS=
RUN ansible-playbook playbook.yml \
    -e omero_web_release=$OMERO_VERSION \
    -e omero_web_omego_additional_args="$OMEGO_ADDITIONAL_ARGS"

RUN curl -L -o /usr/local/bin/dumb-init \
    https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init
ADD entrypoint.sh /usr/local/bin/
ADD 50-config.py 60-default-web-config.sh 98-cleanprevious.sh 99-run.sh /startup/
ADD ice.config /opt/omero/web/OMERO.web/etc/

USER omero-web
EXPOSE 4080
VOLUME ["/opt/omero/web/OMERO.web/var"]

ENV OMERODIR=/opt/omero/web/OMERO.web/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

USER root
RUN rm -rf /opt/omero/web/OMERO.web/lib/python/*
RUN /opt/omero/web/venv/bin/pip install https://github.com/snoopycrimecop/omero-py/archive/merge_ci.zip
RUN /opt/omero/web/venv/bin/pip install https://github.com/snoopycrimecop/omero-web/archive/merge_ci.zip
RUN /opt/omero/web/venv/bin/pip install https://github.com/snoopycrimecop/omero-marshal/archive/merge_ci.zip
ENV OMERODIR /opt/omero/web/OMERO.web
ENV OMERO_HOME /opt/omero/web/OMERO.web
USER omero-web
