# Makefile for various tasks with or around the code.
#

SHELL := /bin/bash -o pipefail -o errexit

.PHONY: all $(MAKECMDGOALS)

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

checks:
	@./.scripts/find-duplicates.sh