OMERO.web Docker
================

[![Actions Status](https://github.com/ome/omero-web-docker/workflows/Build/badge.svg)](https://github.com/ome/omero-web-docker/actions)

A RockyLinux 9 based Docker image for OMERO.web.

Also see [SUPPORT.md](./SUPPORT.md)

Running OMERO with docker-compose
---------------------------------

 The [omero-deployment-examples repository](https://github.com/ome/omero-deployment-examples/) repository
contains a number of different ways of deployment OMERO. Unless you are looking for something
specific, *we suggest starting with [docker-example-omero](https://github.com/ome/docker-example-omero).*

Standalone image: omero-web-standalone
--------------------------------------

The quickest way to obtain a running OMERO.web server is to use
the [standalone image](https://hub.docker.com/r/openmicroscopy/omero-web-standalone/)
which uses the [WhiteNoise package](http://whitenoise.evans.io/en/stable/)
to avoid the need for Nginx.
This image also includes these OMERO.web plugins with a default configuration:
- [figure](https://www.openmicroscopy.org/omero/figure/)
- [iviewer](https://www.openmicroscopy.org/omero/iviewer/)
- [mapr](https://pypi.org/project/omero-mapr/)
- [parade](https://pypi.org/project/omero-parade/)

The following plugins are installed but disabled:
- [fpbioimage](https://pypi.org/project/omero-fpbioimage/)
- [autotag](https://pypi.org/project/omero-autotag/)
- [tagsearch](https://pypi.org/project/omero-webtagging-tagsearch)

To enable them or to change the configuration of a default plugin see the relevant plugin documentation.


To run the Docker image you can set a single OMERO.server to connect to by defining `OMEROHOST`:

    docker run -d --name omero-web-standalone \
        -e OMEROHOST=omero.example.org \
        -p 4080:4080 \
        openmicroscopy/omero-web-standalone

Alternatively, all configuration options can be set using environment variables, for example,
add the following arguments to the command above:

        -e CONFIG_omero_web_server__list='[["omero.example.org", 4064, "omero"]]' \
        -e CONFIG_omero_web_debug=true \

The `$OMERODIR` is `/opt/omero/web/OMERO.web/` so you can have the logs written to your host
by adding:

        -v /path/to/host/dir:/opt/omero/web/OMERO.web/var/logs \

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


Development
-----------

You can use this repository to build a custom image for testing development builds of OMERO.web.
For example, to install OMERO.web from the `OMERO-build` CI job:

    make VERSION=test REPO=test BUILDARGS="\
        --build-arg OMEGO_ADDITIONAL_ARGS=--ci=https://web-proxy.openmicroscopy.org/west-ci/ \
        --build-arg=OMERO_VERSION=OMERO-build" docker-build

    docker run -d --name test-web \
        -e CONFIG_omero_web_server__list='[["eel.openmicroscopy.org", 4064, "eel"]]' \
        -e CONFIG_omero_web_debug=true \
        -p 4080:4080 \
        test/omero-web-standalone:latest
