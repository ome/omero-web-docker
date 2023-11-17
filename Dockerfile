FROM ubuntu:22.04
LABEL maintainer="ome-devel@lists.openmicroscopy.org.uk"

ENV LANG en_US.utf-8
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /opt/setup
WORKDIR /opt/setup
ADD playbook.yml requirements.yml /opt/setup/

RUN apt update \
    && apt -y install ansible sudo dumb-init \
    && ansible-galaxy install -p /opt/setup/roles -r requirements.yml \
    && apt -y autoclean autoremove \
    && rm -fr /var/lib/apt/lists/* /tmp/*

RUN ansible-playbook playbook.yml \
    && apt -y autoclean autoremove \
    && rm -fr /var/lib/apt/lists/* /tmp/*

ADD entrypoint.sh /usr/local/bin/
ADD 50-config.py 60-default-web-config.sh 98-cleanprevious.sh 99-run.sh /startup/
ADD ice.config /opt/omero/web/OMERO.web/etc/

USER omero-web
EXPOSE 4080
VOLUME ["/opt/omero/web/OMERO.web/var"]

ENV OMERODIR=/opt/omero/web/OMERO.web/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
