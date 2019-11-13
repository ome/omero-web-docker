#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero
cd /opt/omero/web
echo "Starting OMERO.web"
exec $python $omero web start --foreground
