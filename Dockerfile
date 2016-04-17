FROM ubuntu:16.04
MAINTAINER Micheal Waltz <ecliptik@gmail.com>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile,  https://github.com/aostanin/docker-plex/blob/master/Dockerfile, and https://github.com/timhaak/docker-plex

#Setup basic environment
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

#Plex install package to download
ENV PLEXPKG=https://downloads.plex.tv/plex-media-server/0.9.16.4.1911-ee6e505/plexmediaserver_0.9.16.4.1911-ee6e505_amd64.deb

#Update apt and system
RUN apt-get -q update && \
    apt-get -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages upgrade && \
    apt-get -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages dist-upgrade

#Install Packages
RUN apt-get install -qy --allow-downgrades --allow-remove-essential --allow-change-held-packages curl

#Download Plex
RUN curl $PLEXPKG -o /var/tmp/plexmediaserver.deb

#Install Plex
RUN [ "dpkg", "--install", "--force-all", "/var/tmp/plexmediaserver.deb" ]

#Clean Up apt
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-fr", "/var/lib/apt/lists/* /tmp/* /var/tmp/* /var/tmp/plexmediaserver.deb" ]

#Volumes
VOLUME [ "/config" ]
VOLUME [ "/data" ]

#Copy start script and make executable
COPY [ "./start.sh", "/app/start.sh" ]
RUN [ "chmod", "+x",  "/app/start.sh" ]

#Expose default Plex media port
EXPOSE 32400

#Set entrypoint of Plex start script
ENTRYPOINT [ "/app/start.sh" ]
