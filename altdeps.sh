#!/bin/sh

LLVM_VER=16.0

#apt-get update

#AFLplusplus
apt-get install make clang$LLVM_VER-devel llvm$LLVM_VER-devel lld$LLVM_VER gcc-c++ gcc-plugin-devel

#spec-fuzzer
apt-get install rust rust-cargo

#QEMU-Nyx
apt-get install glib2-devel zlib-devel glibc-devel libpixman-devel

#packer
apt-get install guestfs-data glibc-devel-static pax-utils

# 32bit (optional):
#apt-get install i586-glibc-nss i586-glibc-core
