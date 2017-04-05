#!/bin/sh
POSTGRES="gosu postgres"
#$POSTGRES pg_ctl -w start
$POSTGRES psql  -c "CREATE ROLE admin ENCRYPTED PASSWORD 'admin' LOGIN SUPERUSER;"
$POSTGRES psql  -c 'CREATE DATABASE urbangis OWNER admin;'
$POSTGRES psql -d urbangis -c 'CREATE EXTENSION postgis;'
$POSTGRES psql -d urbangis -c 'GRANT ALL ON geometry_columns TO PUBLIC;'
$POSTGRES psql -d urbangis -c 'GRANT ALL ON spatial_ref_sys TO PUBLIC;'
if [ -d /docker-entrypoint-initdb.d ]; then
    for f in /docker-entrypoint-initdb.d/*.dump; do
        [ -f "$f" ] && $POSTGRES psql -d urbangis -f "$f"
    done
fi
#$POSTGRES pg_ctl stop
