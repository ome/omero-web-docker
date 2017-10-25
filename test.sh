#!/bin/bash

set -e
set -u

PREFIX=test
IMAGE=omero-web:$PREFIX
STANDLONE=omero-web-standalone:$PREFIX

CLEAN=${CLEAN:-y}

cleanup() {
    docker rm -f -v $PREFIX-web
}

if [ "$CLEAN" = y ]; then
    trap cleanup ERR EXIT
fi

cleanup || true


docker build -t $IMAGE .
docker run -d --name $PREFIX-web \
    -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "test-omero"]]' \
    -e CONFIG_omero_web_debug=true \
    -p 4080:4080 \
    $IMAGE

bash test_getweb.sh

# Standalone image
cleanup
sed -i "s/FROM .*/FROM $IMAGE/" standalone/Dockerfile

docker build -t $STANDLONE standalone/
docker run -d --name $PREFIX-web \
    -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "test-omero"]]' \
    -e CONFIG_omero_web_debug=true \
    -p 4080:4080 \
    $STANDLONE

bash test_getweb.sh
