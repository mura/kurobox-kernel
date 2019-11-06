#!/bin/sh
PATH="$PATH:/opt/toolchain/arm-2008q3/bin"
export PATH
CFLAGS='-O3 -mcpu=arm9 -mtune=arm9'
export CFLAGS

KERNELVER='2.6.30.4'
LOCALVERSION="-1.kuroboxPRO"
ARCH='arm'
CROSS_PREFIX='arm-none-linux-gnueabi-'
INSTALL_DIR=`pwd`/kernel-${KERNELVER}${LOCALVERSION}

pushd linux-${KERNELVER}
gmake ARCH=${ARCH} CROSS_COMPILE=${CROSS_PREFIX} clean
gmake ARCH=${ARCH} CROSS_COMPILE=${CROSS_PREFIX} oldconfig
gmake ARCH=${ARCH} CROSS_COMPILE=${CROSS_PREFIX} zImage modules modules_install INSTALL_MOD_PATH=${INSTALL_DIR}
#${CROSS_PREFIX}objcopy -O binary vmlinux ${INSTALL_DIR}/vmlinux-${KERNELVER}_kuroboxPRO
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n 'linux' -d arch/arm/boot/zImage ${INSTALL_DIR}/uImage.buffalo.${KERNELVER}${LOCALVERSION}
cp -p System.map ${INSTALL_DIR}/System.map-${KERNELVER}${LOCALVERSION}
popd
