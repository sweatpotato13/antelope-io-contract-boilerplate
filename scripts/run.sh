#bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR
docker run -d --name eosio -p 8888:8888 -v $DIR/blockchain/nodeos-data-volume/nodeos-data/config:/etc/nodeos -v $DIR/blockchain/nodeos-data-volume/nodeos-data/data:/data -v $DIR/blockchain/nodeos-data-volume/nodeos-data/contracts:/contracts -it eostudio/eos:v2.0.7 /usr/bin/nodeos --data-dir=/data --config-dir=/etc/nodeos --genesis-json=/etc/nodeos/genesis.json --delete-all-blocks