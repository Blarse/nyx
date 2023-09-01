#!/bin/sh -efu



# Build AFLplusplus
cd AFLplusplus
# fix afl_network_proxy build
sed -i  '/^all:/i LDFLAGS += -ldl\n' ./utils/afl_network_proxy/GNUmakefile

make NO_NYX=1 -j $(nproc) source-only

cd -
