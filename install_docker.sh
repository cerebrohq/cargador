#!/bin/bash

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

mkdir -p ./logs

echo "Installing docker..."

if !(command_exists docker) ; then
	if !(command_exists curl) ; then
		echo "curl command not found, please install curl"
		exit 2
	fi

	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh > ./logs/docker_install.log

	echo "Docker installed successfully"
else
	echo "Docker already installed, update skipped. If you Want to update docker use -u true parameter"
fi
