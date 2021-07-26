project(main)

set(EOSIO_WASM_OLD_BEHAVIOR "Off")
find_package(eosio.cdt)

add_contract( main main main.cpp )
target_include_directories( main PUBLIC ${CMAKE_SOURCE_DIR}/../include )
target_ricardian_directory( main ${CMAKE_SOURCE_DIR}/../ricardian )