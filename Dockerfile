# Source : https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211517-creez-votre-premier-dockerfile

# Build with  'docker build -t clonezilla .'
FROM debian:11

RUN echo ### BUILDING CLONEZILLA IMAGE ###
RUN apt update -yq \
&& apt install wget curl gnupg -yq \
&& apt clean -y

# Generic install
RUN apt install nano net-tools dnsutils ncdu mc procps sed -y

# https://www.skyminds.net/linux-cannot-set-default-locale/
# Set locales
#RUN apt install locales -y
#RUN locale-gen "en_US.UTF-8"
#RUN dpkg-reconfigure locales

### Compilation de ipxe #####################################
RUN apt install git -yq
RUN apt install gcc binutils make perl liblzma-dev mtools mkisofs syslinux -yq

# Recuperation des sources ipxe
WORKDIR /
RUN git clone https://github.com/ipxe/ipxe.git

# Copie de boot.ipxe dans /ipxe/src/
COPY boot.ipxe /ipxe/src/

# On active des parametres de config avant compilation
WORKDIR /ipxe/src/
RUN cp -vf config/console.h config/console.h.ORI
RUN cp -vf config/general.h config/general.h.ORI
RUN sed -i 's/\/\/\#define\tCONSOLE_FRAMEBUFFER/\#define\tCONSOLE_FRAMEBUFFER/g' config/console.h
RUN sed -i 's/\/\/\#define REBOOT_CMD/\#define REBOOT_CMD/g' config/general.h
RUN sed -i 's/\/\/\#define CONSOLE_CMD/\#define CONSOLE_CMD/g' config/general.h

# Compilation des images de boot
WORKDIR /ipxe/src/
RUN make bin/ipxe.lkrn bin-x86_64-efi/ipxe.efi EMBED=boot.ipxe
RUN make bin/undionly.kpxe EMBED=boot.ipxe

### Copie de fichier déplacée au lancement du container dans /runipxe.sh
#RUN cp bin-x86_64-efi/ipxe.efi /srv/tftp/ipxe.efi
#RUN cp bin/undionly.kpxe /srv/tftp/undionly.kpxe
##############################################################

### PREPARATION DU SCRIPT EXEC DU CONTAINER ####################
WORKDIR /
COPY runipxe.sh /
RUN chmod 744 /runipxe.sh 

# Infinite loop
# CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
CMD /runipxe.sh
################################################################
