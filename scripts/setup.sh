#bin/sh

DIR="$( pwd )"
echo $DIR

. $DIR/scripts/constant.sh

CONTAINER_NAME=eosio
PUBLIC_KEY=EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
PRIVATE_KEY=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

docker rm -f $CONTAINER_NAME

docker run -d --name $CONTAINER_NAME -p 8888:8888 -v $DIR/blockchain/nodeos-data-volume/nodeos-data/config:/etc/nodeos -v $DIR/blockchain/nodeos-data-volume/nodeos-data/data:/data -v $DIR/blockchain/nodeos-data-volume/nodeos-data/contracts:/contracts -v $DIR/build:/$CONTRACT_NAME -it eostudio/eos:v2.0.7 /usr/bin/nodeos --data-dir=/data --config-dir=/etc/nodeos --genesis-json=/etc/nodeos/genesis.json --delete-all-blocks

docker exec $CONTAINER_NAME keosd &
sleep 1
docker exec $CONTAINER_NAME cleos wallet create --to-console
docker exec $CONTAINER_NAME cleos wallet import --private-key $PRIVATE_KEY

sleep 1
curl -X POST http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations -d '{"protocol_features_to_activate": ["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}'
sleep 1
curl -X POST http://127.0.0.1:8888/v1/chain/get_activated_protocol_features -d '{}'

docker exec $CONTAINER_NAME cleos set contract eosio /contracts/old_versions/eosio.bios -p eosio
sleep 1s
docker exec $CONTAINER_NAME cleos push action eosio activate '["299dcb6af692324b899b39f16d5a530a33062804e41f09dc97e9f156b4476707"]' -p eosio
sleep 1s
docker exec $CONTAINER_NAME cleos set contract eosio /contracts/eosio.bios -p eosio

sleep 1
docker exec $CONTAINER_NAME cleos create account eosio eosio.token $PUBLIC_KEY -p eosio
docker exec $CONTAINER_NAME cleos create account eosio eosio.msig $PUBLIC_KEY -p eosio
docker exec $CONTAINER_NAME cleos create account eosio eosio.wrap $PUBLIC_KEY -p eosio
docker exec $CONTAINER_NAME cleos create account eosio $CONTRACT_NAME $PUBLIC_KEY -p eosio

sleep 1
docker exec $CONTAINER_NAME cleos set contract eosio.token /contracts/eosio.token -p eosio.token
docker exec $CONTAINER_NAME cleos set contract eosio.msig /contracts/eosio.msig -p eosio.msig

sleep 1
docker exec $CONTAINER_NAME cleos push action eosio.token create '["eosio", "1000000000.0000 EOS"]' -p eosio.token

sleep 1
docker exec $CONTAINER_NAME cleos push action eosio.token issue '["eosio", "1000000000.0000 EOS", "init"]' -p eosio

sleep 1
docker exec $CONTAINER_NAME cleos set contract eosio /contracts/eosio.system -p eosio
docker exec $CONTAINER_NAME cleos set contract eosio.wrap /contracts/eosio.wrap -p eosio.wrap

docker exec $CONTAINER_NAME cleos set contract $CONTRACT_NAME /$CONTRACT_NAME -p $CONTRACT_NAME