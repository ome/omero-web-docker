#!/bin/bash
# Override omero.web.server_list with OMEROHOST if set

set -eu

omero=/opt/omero/web/venv3/bin/omero

OMEROHOST=${OMEROHOST:-}
if [ -n "$OMEROHOST" ]; then
    $omero config set omero.web.server_list "[[\"$OMEROHOST\", 4064, \"omero\"]]"
fi
