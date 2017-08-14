OMERO.web Docker
================

A CentOS 7 based Docker image for OMERO.web.


Running the image
-----------------

To run the Docker image you can set a single OMERO.server to connect to by defining `OMEROHOST`:

    docker run -d --name omero-web \
        -e OMEROHOST=omero.example.org \
        -p 4080:4080 \
        openmicroscopy/omero-web

Alternative all configuration options can be set using environment variables, for example:

    docker run -d --name omero-web \
        -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "omero"]]' \
        -e CONFIG_omero_web_debug=true \
        -p 4080:4080 \
        openmicroscopy/omero-web


Configuration
-------------

All [OMERO configuration properties](www.openmicroscopy.org/site/support/omero/sysadmins/config.html) can be set be defining environment variables `CONFIG_omero_property_name=`.
Since `.` is not allowed in a variable name `.` must be replaced by `_`, and `_` by `__`.

Additional configuration files for OMERO can be provided by mounting files into `/opt/omero/web/config/`.
Files will be loaded with `omero load`.

See https://github.com/manics/omero-server-docker for more details on configuration.


Default volumes
---------------

- `/opt/omero/web/OMERO.web/var`: The OMERO.web `var` directory, including logs


Exposed ports
-------------

- 4080
