#!/bin/sh
cp -vf /ipxe/src/bin-x86_64-efi/ipxe.efi /srv/tftp/ipxe.efi
cp -vf /ipxe/src/bin/undionly.kpxe /srv/tftp/undionly.kpxe

exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
