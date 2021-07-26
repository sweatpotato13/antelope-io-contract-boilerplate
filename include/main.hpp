#pragma ones
#include <eosio/eosio.hpp>

namespace Main {
    class [[eosio::contract]] main : public eosio::contract {
      private:

      public:
        main(eosio::name receiver, eosio::name code, eosio::datastream<const char *> ds)
            : contract(receiver, code, ds) {
        }
        [[eosio::action]] void init();
        using initAction = eosio::action_wrapper<eosio::name("init"), &main::init>;    
    };
}   // namespace Main