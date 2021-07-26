cmake_minimum_required(VERSION 3.5)
project(main_tests)
find_package(eosio.cdt)
add_native_executable(main.test main.test.cpp ${CMAKE_SOURCE_DIR}/../src/main.cpp)
target_include_directories(main.test PUBLIC ${CMAKE_SOURCE_DIR}/../include)

### add a new test
include (CTest)
enable_testing()
add_test(main.test ${CMAKE_BINARY_DIR}/tests/main.test)