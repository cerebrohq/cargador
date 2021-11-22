#!/bin/bash

curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/install_docker.sh -o ./install_docker.sh
chmod +x install_docker.sh
sh install_docker.sh

mkdir -p ./cargador
if [ -z "$(ls -A ./cargador)" ]; then
	echo "Sources directory 'cargador' is empty! Please make cargador binary structure"
	exit 2
fi

docker rmi cerebro1/cargador

if docker build --tag cerebro1/cargador . ; then
	read -p "Do you want to upload this build to repo?[Y/N]" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		docker login --username=cerebro1 --password $1
		docker push cerebro1/cargador
	fi
fi