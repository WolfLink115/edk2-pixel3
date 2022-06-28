#!/bin/bash
# based on the instructions from edk2-platform
set -e
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p Pixel3XL/Pixel3XL.dsc
gzip -c < workspace/Build/Pixel3XL/DEBUG_GCC5/FV/PIXEL3XL_UEFI.fd >workspace/Build/MSM8992_UEFI.fd.gz
cat workspace/Build/MSM8992_UEFI.fd.gz device_specific/fdt.img > workspace/Build/Image.gz-dtb
mkbootimg --kernel workspace/Build/Image.gz-dtb --ramdisk device_specific/ramdisk-null --base 0x00000000 --pagesize 4096 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 -o uefi.img
rm -r workspace/Build
