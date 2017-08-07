#!/bin/bash
# Use omero.web.server_list if set, othen OMEROHOST if set, defaulting to a
# single server of omero
# Also default to binding web to all IPs

set -eu

omero=/opt/omero/web/OMERO.web/bin/omero

OMEROHOST=${OMEROHOST:-omero}
CONFIG_omero_web_server__list=${CONFIG_omero_web_server__list:-}

if [ -z "$CONFIG_omero_web_server__list" ]; then
    $omero config set omero.web.server_list "[[\"$OMEROHOST\", 4064, \"omero\"]]"
fi

CONFIG_omero_web_application__server_host=${CONFIG_omero_web_application__server_host:-}
if [ -z "$CONFIG_omero_web_application__server_host" ]; then
    $omero config set omero.web.application_server.host "0.0.0.0"
fi
