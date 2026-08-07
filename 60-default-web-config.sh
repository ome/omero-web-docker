#!/bin/bash
# Override omero.web.server_list with OMEROHOST if set

set -eu

omero=/opt/omero/web/venv3/bin/omero

OMEROHOST=${OMEROHOST:-}
OMEROPORT=${OMEROPORT:-}
if [ -n "$OMEROHOST" ]; then
    if [ -n "$OMEROPORT" ]; then
        $omero config set omero.web.server_list "[[\"$OMEROHOST\", \"$OMEROPORT\", \"omero\"]]"
    else
        $omero config set omero.web.server_list "[[\"$OMEROHOST\", 4064, \"omero\"]]"
    fi
else
    if [-n "$OMEROPORT" ]; then
        $omero config set omero.web.server_list "[[\"localhost\", \"$OMEROPORT\", \"omero\"]]"
    fi
fi
