#!/bin/sh

### Prerequis installation ###

sudo apt install gcc binutils make perl liblzma-dev mtools mkisofs syslinux git -yq
# Package mkisofs is not available, but is referred to by another package.
# This may mean that the package is missing, has been obsoleted, or
# is only available from another source
# However the following packages replace it:
#  genisoimage
sudo apt install gcc binutils make perl liblzma-dev mtools genisoimage syslinux git -yq

### Getting ipxe drivers from github ###
script_dir=$(realpath $(dirname $0))
echo
echo ### git clone ipxe in $script_dir/ipxe ###
cd $script_dir/../
echo "Cloning ipxe"
git clone https://github.com/ipxe/ipxe.git

### Compilation ###
echo
echo "BE SURE TO MODIFY $script_dir/boot.ipxe TO YOUR NEEDS BEFORE COMPILING !!!!!!"
read -p "  Hit ENTER or CTRL-C ..." dummy
cp -vf $script_dir/boot.ipxe $script_dir/../ipxe/src/
cd ipxe/src
make -j4 bin/ipxe.lkrn bin-x86_64-efi/ipxe.efi EMBED=boot.ipxe
make -j4 bin/undionly.kpxe EMBED=boot.ipxe
