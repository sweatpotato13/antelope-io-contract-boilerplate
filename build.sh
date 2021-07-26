#bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR
docker run --rm -v $DIR:/contracts -it eostudio/eosio.cdt:v1.7.0 eosio-cpp -O 3 -I /contracts/include/ -R /contracts/ricardian/ -o /contracts/main.wasm /contracts/src/main.cpp --abigen
