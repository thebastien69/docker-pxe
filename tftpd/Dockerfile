# Source : https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211517-creez-votre-premier-dockerfile

# Build with  'docker build -t tftpd .'

FROM debian:11

RUN apt update -yq \
&& apt install curl gnupg -yq \
&& apt clean -y


# Configuration de tftpd
RUN apt install tftpd-hpa nano net-tools dnsutils ncdu mc procps -y
#WORKDIR /
#ADD . /app/
#RUN mkdir /tftpboot
COPY runmeatboot.sh /
RUN chmod 744 /runmeatboot.sh 

#
# Utilisez l'instruction  ADD  afin de copier ou de télécharger des fichiers dans l'image.
# Dans notre cas, nous l'utilisons pour ajouter les sources de notre application locale
# dans le dossier /app/ de l'image.
#
# ADD . /app/

#
# Utilisez ensuite l'instruction WORKDIR qui permet de modifier le répertoire courant.
# La commande est équivalente à une commande cd en ligne de commande.
# L'ensemble des commandes qui suivront seront toutes exécutées depuis le répertoire défini.
#
# WORKDIR /app

#
# Puis, l'instruction RUN suivante permet d'installer le package du projet Node.js.
#
# RUN npm install


# L'instruction EXPOSE permet d'indiquer le port sur lequel votre application écoute.
# L'instruction VOLUME permet d'indiquer quel répertoire vous voulez partager avec votre host.

EXPOSE 69
#VOLUME /app/logs

# Infinite loop
# CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
#CMD in.tftpd -L -vvv -u ftp --secure --address "0.0.0.0:69" /tftpboot && exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
CMD /runmeatboot.sh
