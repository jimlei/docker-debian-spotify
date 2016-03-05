FROM ubuntu:14.04
MAINTAINER Jim Leirvik <jim@jimleirvik.no>

ENV TERM xterm
ENV HOME /home/spotify
ENV PULSE_SERVER /run/pulse/native

RUN 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 && \
	echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list && \
	apt-get update && apt-get install -y \
	libpangoxft-1.0-0 \
	alsa-utils \
	xdg-utils \
	libxss1 \
	pulseaudio \
	software-properties-common \
	--no-install-recommends && \
	apt-get install --force-yes -y \
	spotify-client && \
	apt-get clean && \
	echo enable-shm=no >> /etc/pulse/client.conf && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN	useradd --create-home --home-dir $HOME spotify && \
	gpasswd -a spotify audio && \
        mkdir -p $HOME/.cache/spotify/Storage && \
	mkdir -p $HOME/.config/spotify && \
	chown -R spotify:spotify $HOME

VOLUME $HOME/.config/spotify
VOLUME $HOME/.cache/spotify/Storage

WORKDIR $HOME
USER spotify

# make search bar text better
RUN echo "QLineEdit { color: #000 }" > $HOME/spotify-override.css

ENTRYPOINT	[ "spotify" ]
CMD [ "-stylesheet=/home/spotify/spotify-override.css" ]
