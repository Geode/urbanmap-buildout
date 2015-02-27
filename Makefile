#!/usr/bin/make
#

all: run

.PHONY: bootstrap
bootstrap:
	virtualenv-2.6 --no-site-packages .
	./bin/python bootstrap.py

.PHONY: buildout
buildout:
	if ! test -f bin/buildout;then make bootstrap;fi
	bin/buildout -vt 5
