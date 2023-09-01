#!/bin/sh -efu

git submodule init

export ALTWRAP_LLVM_VERSION=15.0
export CC=clang
export CXX=clang++
export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export RANLIB=llvm-ranlib

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
