FROM rockylinux:9
LABEL maintainer="ome-devel@lists.openmicroscopy.org.uk"

RUN mkdir /opt/setup
WORKDIR /opt/setup
ADD playbook.yml requirements.yml /opt/setup/

RUN dnf -y update \
  && dnf -y install epel-release glibc-langpack-en python3.12-devel.x86_64 -y \
  python3.12 -y python3.12-pip python3.12-setuptools

RUN python3.12 -m pip install 'pip @ https://files.pythonhosted.org/packages/3f/06/3e4420302363fbb71be3c7f35ce042f54bfca330e3e66b3a2e3c4cca579f/pip-26.2.2-py3-none-any.whl#sha256=fd7f4dfa8190e014013b9f08f3e973f4e4c26ffd179a204895533a7254813a70' \
  && \
  python3.12 -m pip install --upgrade 'certifi>=2026.10.19'

RUN dnf install -y  ansible-core sudo ca-certificates

RUN dnf clean all

ENV LANG en_US.utf-8

RUN python3.12 -m pip  install ansible

RUN ansible-galaxy install -p /opt/setup/roles -r requirements.yml \
    && dnf -y clean all \
    && rm -fr /var/cache

RUN ansible-playbook playbook.yml -e 'ansible_python_interpreter=/usr/bin/python3.12' \
    && dnf -y clean all \
    && rm -fr /var/cache

RUN curl -L -o /usr/local/bin/dumb-init \
    https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && \
    chmod +x /usr/local/bin/dumb-init
ADD entrypoint.sh /usr/local/bin/
ADD 50-config.py 60-default-web-config.sh 98-cleanprevious.sh 99-run.sh /startup/
ADD ice.config /opt/omero/web/OMERO.web/etc/

USER omero-web
EXPOSE 4080
VOLUME ["/opt/omero/web/OMERO.web/var"]

ENV OMERODIR=/opt/omero/web/OMERO.web/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
