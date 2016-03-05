Debian docker image with Spotify using pulseaudio.

```bash
$ docker run -e DISPLAY \
	--net=host \
	--device /dev/snd \
	-v $HOME/.Xauthority:/home/spotify/.Xauthority \
	-v /etc/localtime:/etc/localtime:ro \
	-v /dev/shm:/dev/shm \
	-v /run/user/$(id -u)/pulse:/run/pulse:ro \
	-v spotify:/home/spotify/.config/spotify \
	--name spotify \
	jimlei/debian-spotify &
```
