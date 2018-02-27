OMERO.web Docker
================

A CentOS 7 based Docker image for OMERO.web.

Also see [SUPPORT.md](./SUPPORT.md)

Standalone image: omero-web-standalone
--------------------------------------

The quickest way to obtain a running OMERO.web server is to use
the [standalone image](https://hub.docker.com/r/openmicroscopy/omero-web-standalone/)
which uses the [WhiteNoise package](http://whitenoise.evans.io/en/stable/)
to avoid the need for Nginx.

To run the Docker image you can set a single OMERO.server to connect to by defining `OMEROHOST`:

    docker run -d --name omero-web \
        -e OMEROHOST=omero.example.org \
        -p 4080:4080 \
        openmicroscopy/omero-web-standalone

Alternative all configuration options can be set using environment variables, for example:

    docker run -d --name omero-web \
        -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "omero"]]' \
        -e CONFIG_omero_web_debug=true \
        -p 4080:4080 \
        openmicroscopy/omero-web-standalone


Minimal OMERO.web image: omero-web
----------------------------------

[omero-web](https://hub.docker.com/r/openmicroscopy/omero-web/)
is a minimal OMERO.web image which requires additional configuration for serving Django static files.
For example, you can use https://github.com/dpwrussell/omero-nginx-docker


Configuration
-------------

All [OMERO configuration properties](https://docs.openmicroscopy.org/latest/omero/sysadmins/config.html) can be set be defining environment variables `CONFIG_omero_property_name=`.
Since `.` is not allowed in a variable name `.` must be replaced by `_`, and `_` by `__`.

Additional configuration files for OMERO can be provided by mounting files into `/opt/omero/web/config/`.
Files ending with `.omero` will be loaded with `omero load`.

See https://github.com/openmicroscopy/omero-server-docker for more details on configuration.


Default volumes
---------------

- `/opt/omero/web/OMERO.web/var`: The OMERO.web `var` directory, including logs


Exposed ports
-------------

- 4080
