FROM ubuntu:14.04.2
MAINTAINER Nicolas Dufrane <nicolas.dufrane@opengeode.be>

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PYTHONUNBUFFERED 1

RUN \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y git python python-dev python-pip libgdal1-dev libpq-dev tree && \
  apt-get install -y libreadline6-dev zlib1g-dev libbz2-dev libjpeg62-dev libxml2-dev libxslt-dev libsqlite3-dev && \
  apt-get install -y openjdk-7-jdk

RUN mkdir -p /srv/urbanmap_buildout
WORKDIR /srv/urbanmap_buildout
ADD . /srv/urbanmap_buildout
RUN pip install virtualenv
RUN make

EXPOSE 8000:8000

WORKDIR /srv/urbanmap_buildout/geode.urbanmap

ADD configuration.ini /srv/urbanmap_buildout/geode.urbanmap/configuration.ini
ADD config.yaml /srv/urbanmap_buildout/geode.urbanmap/print/config.yaml
ADD print-standalone-1.2-SNAPSHOT.jar /srv/urbanmap_buildout/geode.urbanmap/print/print-standalone-1.2-SNAPSHOT.jar

RUN pip install uwsgi
RUN ../bin/pip install -r ../requirements.txt
RUN chmod +x ../uwsgi.sh

#CMD ["../bin/paster", "serve", "configuration.ini"]
CMD ["../uwsgi.sh"]
