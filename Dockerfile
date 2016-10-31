FROM ubuntu:16.04
MAINTAINER Micheal Waltz <ecliptik@gmail.com>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile,  https://github.com/aostanin/docker-plex/blob/master/Dockerfile, and https://github.com/timhaak/docker-plex

#Setup basic environment
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

#Plex install package to download
ENV PLEXPKG=https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver_1.1.4.2757-24ffd60_amd64.deb

#App Dir var
ENV APPDIR=/app

#Volumes
VOLUME /config
VOLUME /data

#Set WORKDIR
WORKDIR ${APPDIR}

#Expose default Plex media port
EXPOSE 32400

#Update system
RUN apt-get -q update && \
    apt-get -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages upgrade && \
    apt-get install -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages curl dbus avahi-daemon && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Install Plex
RUN curl -O ${PLEXPKG} && \
    dpkg --install --force-all plexmediaserver_*.deb && \
    rm -fr plexmediaserver_*.deb

#Copy start script and make executable
COPY start.sh start.sh
RUN chmod +x start.sh

#Set entrypoint of Plex start script
ENTRYPOINT [ "/app/start.sh" ]
