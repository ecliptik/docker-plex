#!/bin/sh

rm -rf /var/run/*
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

if [ -f /config/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml ]; then
    echo "$(date -R) Starting Plex"
    HOME=/config start_pms
    tail -F /config/Library/Application\ Support/Plex\ Media\ Server/Logs/**/*.log
else
    echo "$(date -R) Starting Plex and generating new configuration"
    HOME=/config start_pms &
    while [ ! -f /config/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml ]; do
        sleep 1
        echo "$(date -R) waiting..."
    done
    echo "$(date -R) Configuration generated.  Please edit"
    echo "$(date -R) Library/Application Support/Plex Media Server/Preferences.xml"
    echo "$(date -R) and add allowedNetworks parameter, then restart the container."
    exit 0
fi
