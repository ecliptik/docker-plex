# docker plex

[![](https://images.microbadger.com/badges/image/ecliptik/docker-plex.svg)](https://microbadger.com/images/ecliptik/docker-plex "Get your own image badge on microbadger.com")

This is a Dockerfile to set up [Plex Media Server](https://plex.tv/)

Build using the Dockerfile

```
git clone git@github.com:ecliptik/docker-plex.git
cd docker-plex
docker build -t plex .
```

You can also obtain it via:

```
docker pull ecliptik/docker-plex
```

Originally from: https://github.com/timhaak/docker-plex

---
Instructions to run:

```
docker run -d -h *your_host_name* -v /*your_config_location*:/config -v /*your_videos_location*:/data -p 32400:32400  plex
```
or for auto detection add --net="host". Though be aware this more insecure but should be fine on your personal servers.

```
docker run -d --net="host" -v /*your_config_location*:/config -v /*your_videos_location*:/data -p 32400:32400  plex
```

The first time it runs, it will initialize the config directory and terminate.

You will need to modify the auto-generated config file to allow connections from your local IP range. This can be done by modifying the file:

*your_config_location*/Library/Application Support/Plex Media Server/Preferences.xml

and adding ```allowedNetworks="192.168.1.0/255.255.255.0" ``` as a parameter in the <Preferences ...> section. (Or what ever your local range is)

Start the docker instance again and it will stay as a daemon and listen on port 32400.

Browse to: ```http://*ipaddress*:32400/web``` to run through the setup wizard.

### Docker Beta
If using the [Docker Beta](https://blog.docker.com/2016/03/docker-for-mac-windows-beta/) on OSX, try the following

```
docker run -d -h $(hostname) -v /*your_config_location*:/config -v /*your_videos_location*:/data -p 32400:32400 plex
```

and then in the local web browser go to [localhost:32400/web](http://localhost:32400/web) to access the locally running container.
