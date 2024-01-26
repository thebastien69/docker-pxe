#!/bin/sh
#/usr/sbin/in.tftpd -L -vvv -u ftp --secure --address "0.0.0.0:69" /tftpboot
#exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
/usr/sbin/in.tftpd -4 -L -vvv --secure --address "0.0.0.0:69" /srv/tftp
