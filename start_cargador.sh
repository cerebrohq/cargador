#!/bin/bash

if docker run --detach --restart=always -p 4040:4040 -p 4080:4080 -p 45431:45431 -p 45430:45430 \
    --name cerebro1/cargador \
    --volume /cerebro/cerebro.files:/cerebro/cerebro.files --volume /docker/cargador/config:/config --volume /docker/cargador/logs:/cerebro/logs --volume /cerebro/backup:/cerebro/backup \
    cerebro1/cargador > /dev/null ; then
	echo "container started successfully"
fi