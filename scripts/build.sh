#bin/sh
DIR="$( pwd )"
echo $DIR
. $DIR/scripts/constant.sh
rm -rf build
mkdir build
FILES="$(ls src | egrep '\.cpp$')"
for file in $FILES
do
    CPPS+="/contracts/src/${file} "
done
echo $CPPS
docker run --rm -v $DIR:/contracts -it eostudio/eosio.cdt:v1.7.0 eosio-cpp -O 3 -I /contracts/include/ -R /contracts/ricardian/ -o /contracts/build/${CONTRACT_NAME}.wasm ${CPPS} --abigen