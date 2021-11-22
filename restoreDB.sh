docker exec cargador /bin/sh -c "/cerebro/cargador/restoreDB.sh $*"

if [ -e ./config/.system/catalog.sqlite.new ]
then
./stop_cargador.sh

rm ./config/.system/catalog.sqlite
mv ./config/.system/catalog.sqlite.new ./config/.system/catalog.sqlite

./start_cargador.sh
fi