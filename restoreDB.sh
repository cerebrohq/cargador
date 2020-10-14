#!/bin/bash

DIRNAME=$(dirname 0)

$DIRNAME/py-site-packages/python.sh $DIRNAME/cron/backupCatalog.py restore $*