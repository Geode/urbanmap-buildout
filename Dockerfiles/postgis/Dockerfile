FROM postgres:9.4
MAINTAINER Nicolas Dufrane <nicolas.dufrane@opengeode.be>

ENV POSTGIS_MAJOR 2.1

RUN apt-get update && apt-get install -y postgresql-9.4-postgis-2.1

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/initdb-postgis.sh
COPY *.dump /docker-entrypoint-initdb.d/
RUN rm -f /var/lib/postgresql/data/postmaster.pid
