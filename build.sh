#bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR
rm -rf build
mkdir build
docker run --rm -v $DIR:/contracts -it eostudio/eosio.cdt:v1.7.0 eosio-cpp -O 3 -I /contracts/include/ -R /contracts/ricardian/ -o /contracts/build/main.wasm /contracts/src/main.cpp --abigen