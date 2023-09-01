#!/bin/sh -efu

git submodule init

# Set clang/llvm version manually:
#export ALTWRAP_LLVM_VERSION=16.0

export CC=clang
export CXX=clang++
export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export RANLIB=llvm-ranlib

# Build AFLplusplus
git submodule update AFLplusplus 2>/dev/null ||:
cd AFLplusplus
# fix afl_network_proxy build
sed -i  '/^all:/i LDFLAGS += -ldl\n' ./utils/afl_network_proxy/GNUmakefile

make NO_NYX=1 -j $(nproc) source-only
git restore ./utils/afl_network_proxy/GNUmakefile
cd -

# Build spec-fuzzer
git submodule update spec-fuzzer 2>/dev/null ||:
cd spec-fuzzer
./setup.sh
cd -

# Build QEMU-nyx
git submodule update QEMU-Nyx 2>/dev/null ||:
cd QEMU-Nyx
LD_FLAVOUR=lld ./compile_qemu_nyx.sh lto
cd -

# Build packer
git submodule update packer 2>/dev/null ||:
cd packer/linux_initramfs
sh ./pack_alt.sh
cd -
