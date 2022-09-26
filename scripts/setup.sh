#bin/sh

DIR="$( pwd )"
echo $DIR

. "$DIR/scripts/constant.sh"

CONTAINER_NAME=eosio
PUBLIC_KEY=EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
PRIVATE_KEY=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

docker rm -f $CONTAINER_NAME

rm -rf "$DIR"/blockchain/nodeos-data-volume/nodeos-data/data/*

docker run -d --name $CONTAINER_NAME -p 8888:8888 -v "$DIR"/blockchain/nodeos-data-volume/nodeos-data/config:/etc/nodeos -v "$DIR"/build:/$CONTRACT_NAME -it sweatpotato/leap:3.1.1-snapshot nodeos --data-dir=/data --config-dir=/etc/nodeos --snapshot /snapshot.bin --disable-replay-opts

sleep 3
