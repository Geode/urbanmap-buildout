#!/bin/bash

# Start Gunicorn processes
echo Starting uWSGI.
exec /usr/local/bin/uwsgi \
    --paste config:/srv/urbanmap_buildout/geode.urbanmap/configuration.ini \
    --socket :8000 \
    --buffer-size=32768 \
    -M \
    -p 4 \
    -H /srv/urbanmap_buildout \
    --chdir /srv/urbanmap_buildout/geode.urbanmap
