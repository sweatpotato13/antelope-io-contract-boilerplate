#include <eosio/eosio.hpp>
#include <eosio/tester.hpp>

#include <main.hpp>

using namespace eosio;
using namespace eosio::native;

// need to create a dispatcher, codegen will not be done for native builds until a later release
EOSIO_DISPATCH(Main::main, (func1)(func2))

EOSIO_TEST_BEGIN(main_test)

intrinsics::set_intrinsic<intrinsics::action_data_size>([]() {
    return (uint32_t)sizeof(eosio::name);
});

intrinsics::set_intrinsic<intrinsics::require_auth>([](capi_name nm) {});

// "Name : lit" should be in the print buffer
// CHECK_PRINT("Name : lit", []() {
//     apply(name("test").value, name("test").value, name("hi").value);
// });

// should not assert
apply(name("test").value, name("test").value, name("check").value);

name nm = name("null");
intrinsics::set_intrinsic<intrinsics::read_action_data>([&](void *m, uint32_t len) {
    check(len <= sizeof(eosio::name), "failed from read_action_data");
    *((eosio::name *)m) = nm;
    return len;
});

REQUIRE_ASSERT("check name not equal to `lit`", []() {
    // should assert
    apply(name("test").value, name("test").value, name("check").value);
});

EOSIO_TEST_END

// boilerplate main, this will be generated in a future release
int main(int argc, char **argv) {
    silence_output(true);
    EOSIO_TEST(main_test);
    return has_failed();
}