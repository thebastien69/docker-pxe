#!/bin/sh
sudo apt install gcc binutils make perl liblzma-dev mtools mkisofs syslinux git -yq
# Package mkisofs is not available, but is referred to by another package.
#This may mean that the package is missing, has been obsoleted, or
#is only available from another source
#However the following packages replace it:
#  genisoimage
sudo apt install gcc binutils make perl liblzma-dev mtools genisoimage syslinux git -yq

git clone https://github.com/ipxe/ipxe.git
cd ipxe/src

make bin/ipxe.lkrn bin-x86_64-efi/ipxe.efi EMBED=boot.ipxe
make bin/undionly.kpxe EMBED=boot.ipxe

### Copie de fichier déplacée au lancement du container dans /rundrbl.sh
#RUN cp bin-x86_64-efi/ipxe.efi /srv/tftp/ipxe.efi
#RUN cp bin/undionly.kpxe /srv/tftp/undionly.kpxe
##############################################################


