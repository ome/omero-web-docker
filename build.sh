#!/bin/bash

set -e
set -u

export PREFIX=${TRAVIS_BRANCH:-test}
if [ -n "${DOCKER_USERNAME:-}" -a -z "${REPO:-}" ]; then
    REPO="${DOCKER_USERNAME}"
else
    REPO="${REPO:-test}"
fi
IMAGE=$REPO/omero-web:$PREFIX
STANDLONE=$REPO/omero-web-standalone:$PREFIX

CLEAN=${CLEAN:-y}

cleanup() {
    docker rm -f -v $PREFIX-web
}

if [ "$CLEAN" = y ]; then
    trap cleanup ERR EXIT
fi

cleanup || true

make VERSION="$PREFIX" REPO="$REPO" docker-build

docker run -d --name $PREFIX-web \
    -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "test-omero"]]' \
    -e CONFIG_omero_web_debug=true \
    -p 4080:4080 \
    $IMAGE

bash test_getweb.sh

# Standalone image
cleanup
docker run -d --name $PREFIX-web \
    -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "test-omero"]]' \
    -e CONFIG_omero_web_debug=true \
    -p 4080:4080 \
    $STANDLONE

bash test_getweb.sh

if [ -n "${DOCKER_USERNAME:-}" ]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    make  VERSION="$PREFIX" REPO="$REPO" docker-push
else
    echo Docker push disabled
fi