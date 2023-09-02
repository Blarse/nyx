#!/bin/sh -efu

kvm_type=kvm-intel
if lsmod | grep -q kvm_amd; then
  kvm_type=kvm_amd
fi

enable=y
if [ -n "${1:-}" ]; then
  enable=n
fi

sudo modprobe -r $kvm_type
sudo modprobe -r kvm
sudo modprobe kvm enable_vmware_backdoor=$enable
sudo modprobe $kvm_type

echo "enable_vmware_backdoor: $(cat /sys/module/kvm/parameters/enable_vmware_backdoor)"
