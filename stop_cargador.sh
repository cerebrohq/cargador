#!/bin/bash

if docker stop cargador > /dev/null && \
    docker rm cargador > /dev/null ; then
	echo "container stopped successfully"
fi