#!/bin/bash

XCOMPILE_BIN=xcompile-bin
SYSROOT=sysroot

if [ ! -e $XCOMPILE_BIN ]; then
	mkdir $XCOMPILE_BIN
fi
pushd $XCOMPILE_BIN

if [ ! -e stratux-v0.3b2-5a568e27ce-09162015.img.zip ]; then
	wget https://github.com/cyoung/stratux/releases/download/v0.3b2/stratux-v0.3b2-5a568e27ce-09162015.img.zip
	unzip stratux-v0.3b2-5a568e27ce-09162015.img.zip
fi

if [ ! -e $SYSROOT ];then
	mkdir $SYSROOT
fi 

sudo kpartx -a stratux-v0.3b2-5a568e27ce-09162015.img
sudo mount /dev/mapper/loop0p2 $SYSROOT

if [ ! -e tools ];then
	git clone https://github.com/raspberrypi/tools/
fi

if [[ ! "PATH" =~ "gcc-linaro-arm-linux-gnueabihf-raspbian/bin" ]];then
	ARCH=$(uname -m)
	if [ "$ARCH" == "x86_64" ];then
		export PATH=$PATH:$PWD/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
	elif [ "$ARCH" == "i386" -o "$ARCH" == "i686" ];then
		export PATH=$PATH:$PWD/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
	fi
fi
popd
