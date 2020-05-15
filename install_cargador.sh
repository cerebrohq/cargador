#!/bin/bash

if [ -f "./stop_cargador.sh" ] ; then
	sh stop_cargador.sh
fi

mkdir -p ./config
mkdir -p ./logs
mkdir -p ./backup

curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/cargador.linux.conf -o ./config/cargador.linux.conf.example
curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/cron_conf.py -o ./config/cron_conf.py.example
curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/main.conf -o ./config/main.conf.example

read -p "Enter delete files password(leave Empty if not need):" cdelpassword

if [ ! -f "./config/cargador.linux.conf" ] ; then
	cp "./config/cargador.linux.conf.example" "./config/cargador.linux.conf"

	read -p "Enter Cargador HTTP-port[4080]: " chttpport
	chttpport=${chttpport:-4080}
	read -p "Enter Cargador RPC-port[4040]: " crpcport
	crpcport=${crpcport:-4040}

	sed -i -E "s~<port>4080</port>~<port>${chttpport}</port>~g" ./config/cargador.linux.conf
	sed -i -E "s~<port>4040</port>~<port>${crpcport}</port>~g" ./config/cargador.linux.conf
	sed -i -E "s~<del_password Value=\"\" />~<del_password Value=\"${cdelpassword}\" />~g" ./config/cargador.linux.conf
else
	echo "cargador.linux.conf already exists and configured"
fi

if [ ! -f "./config/cron_conf.py" ] ; then
	cp "./config/cron_conf.py.example" "./config/cron_conf.py"
	
	if [ ! -z "$cdelpassword" ] ; then
		sed -i -E "s~CARGADOR_DEL_PASSWORD='' # password for sweeping files.~CARGADOR_DEL_PASSWORD='${cdelpassword}' # password for sweeping files.~g" ./config/cron_conf.py
	fi
else
	echo "cron_conf.py already exists and configured"
fi

if [ ! -f "./config/main.conf" ] ; then
	cp "./config/main.conf.example" "./config/main.conf"
	
	read -e -p "Enter content files root directory:" filesdir
	mkdir -p "$filesdir"
	
	sed -i -E "s~<net_root Value=\"/cerebro/cerebro.files\" />~<net_root Value=\"//$HOSTNAME/${filesdir##*/}\" />~g" ./config/main.conf
else
	echo "main.conf already exists and configured"
fi

curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/install_docker.sh -o ./install_docker.sh
chmod +x install_docker.sh
sh install_docker.sh

systemctl restart docker
sleep 5

docker pull cerebro1/cargador:latest

if [ ! -f "./start_cargador.sh" ] ; then
	curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/start_cargador.sh -o ./start_cargador.sh
	curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/stop_cargador.sh -o ./stop_cargador.sh
	curl -fsSL https://raw.githubusercontent.com/cerebrohq/cargador/master/restart_cargador.sh -o ./restart_cargador.sh
	
	chmod +x start_cargador.sh
	chmod +x stop_cargador.sh
	chmod +x restart_cargador.sh
	
	sed -i -E "s~4040:4040~${crpcport}:${crpcport}~g" ./start_cargador.sh
	sed -i -E "s~4080:4080~${chttpport}:${chttpport}~g" ./start_cargador.sh
	
	sed -i -E "s~/cerebro/cerebro.files:/cerebro/cerebro.files~${filesdir}:/cerebro/cerebro.files~g" ./start_cargador.sh
	sed -i -E "s~/docker/cargador/config:/config~$PWD/config:/config~g" ./start_cargador.sh
	sed -i -E "s~/docker/cargador/logs:/cerebro/logs~$PWD/logs:/cerebro/logs~g" ./start_cargador.sh
	sed -i -E "s~/cerebro/backup:/cerebro/backup~$PWD/backup:/cerebro/backup~g" ./start_cargador.sh
else
	echo "start_cargador.sh already exists and configured"
fi

sh start_cargador.sh