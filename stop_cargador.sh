#!/bin/bash

if docker stop cerebro1/cargador > /dev/null && \
    docker rm cerebro1/cargador > /dev/null ; then
	echo "container stopped successfully"
fi