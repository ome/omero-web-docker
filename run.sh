#!/bin/bash

set -eu

if [ $# -gt 0 ]; then
    echo "ERROR: Expected 0 args"
    exit 2
fi

omero=/home/omero/OMERO.server/bin/omero

MASTER_ADDR=${MASTER_ADDR:-}
if [ -z "$MASTER_ADDR" ]; then
    MASTER_ADDR=master
fi
if [ -n "$MASTER_ADDR" ]; then
    $omero config set omero.web.server_list "[[\"$MASTER_ADDR\", 4064, \"omero\"]]"
else
    echo "WARNING: Master address not found"
    # Assume it'll be set in /config/*
fi

if stat -t /config/* > /dev/null 2>&1; then
    for f in /config/*; do
        echo "Loading $f"
        $omero load "$f"
    done
fi

echo "Starting OMERO.web"
$omero web start
echo "Starting nginx"
exec nginx -g "daemon off;" -c /etc/nginx/nginx.conf
