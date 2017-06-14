#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero
cd /opt/omero/web
echo "Starting OMERO.web"
exec $python $omero web start --foreground
