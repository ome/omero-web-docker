#!/bin/bash

echo "Activating virtualenv"
. /opt/omero/web/venv/bin/activate

set -eu

omero=/opt/omero/web/OMERO.web/bin/omero
cd /opt/omero/web
echo "Starting OMERO.web"
exec python $omero web start --foreground
