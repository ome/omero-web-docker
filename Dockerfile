FROM centos:centos7
LABEL maintainer="ome-devel@lists.openmicroscopy.org.uk"
LABEL org.opencontainers.image.created="2021-03-17T14:18:04Z"
LABEL org.opencontainers.image.revision="58ead3a64142b88b99aac9637f0e6ac7f8dd403d"
LABEL org.opencontainers.image.source="https://github.com/ome/omero-web-docker"


RUN mkdir /opt/setup
WORKDIR /opt/setup
ADD playbook.yml requirements.yml /opt/setup/

RUN yum -y install epel-release \
    && yum -y install ansible sudo \
    && ansible-galaxy install -p /opt/setup/roles -r requirements.yml

RUN ansible-playbook playbook.yml

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
