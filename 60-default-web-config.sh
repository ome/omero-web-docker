#!/bin/bash
# If omero.web.server_list is unset but the variable MASTER_ADDR exists then
# use this to configure the server list

set -eu

omero=/opt/omero/web/OMERO.web/bin/omero

CONFIG_omero_web_server__list=${CONFIG_omero_web_server__list:-}
MASTER_ADDR=${MASTER_ADDR:-}
if [ -z "$CONFIG_omero_web_server__list" -a -n "$MASTER_ADDR" ]; then
    $omero config set omero.web.server_list "[[\"$MASTER_ADDR\", 4064, \"omero\"]]"
fi
CONFIG_omero_web_application__server_host=${CONFIG_omero_web_application__server_host:-}
if [ -z "$CONFIG_omero_web_application__server_host" ]; then
    $omero config set omero.web.application_server.host "0.0.0.0"
fi
