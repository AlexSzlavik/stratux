# Cross-compile gen_gdl90 from linux to ARM7

- Download the latest official image https://github.com/cyoung/stratux/releases/download/v0.3b1/stratux-v0.3b1-7e61c7556a-09112015.img.zip
-- Alternatively download raspberry pi image

- Unzip image
-- unzip stratux-v0.3b2-5a568e27ce-09162015.img.zip

- Find the offset of the root partition
-- fdisk stratux-v0.3b2-5a568e27ce-09162015.img

- Create a mountpoint
-- mkdir mnt

- Mount the root FS
-- mount -o loop,offset=$((512*<LBA of root FS above>)) stratux-v0.3b2-5a568e27ce-09162015.img mnt

- Download the cross compile sources from https://github.com/raspberrypi/tools/
-- git clone https://github.com/raspberrypi/tools/

- Setup the cross compiler (x86-64 linux host)
-- export PATH=$PATH:$PWD/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin

- Compile!
-- GO_LDFLAGS="--sysroot=/home/alex/git/stratux/mnt" CGO_CFLAGS="--sysroot=/home/alex/git/stratux/mnt/ -isystem=usr/local/include" CC=arm-linux-gnueabihf-gcc CGO_ENABLED=1 make

- Explanation of above
-- GO_LDFLAGS: passed to go linker to find librtlsdr
-- CGO_CFLAGS: passed to cgo to find includes
-- CC: passed to go to replace cgo gcc with our cross-compiler
-- CGO_ENABLED=1 : Required to enable cgo during cross-compilation
