#!/bin/sh -efu

git submodule init

# Build AFLplusplus
git submodule update AFLplusplus 2>/dev/null
cd AFLplusplus
# fix afl_network_proxy build
sed -i  '/^all:/i LDFLAGS += -ldl\n' ./utils/afl_network_proxy/GNUmakefile

make NO_NYX=1 -j $(nproc) source-only
cd -


# Build spec-fuzzer
git submodule update spec-fuzzer 2>/dev/null
cd spec-fuzzer
./setup.sh
cd -
