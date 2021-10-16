FROM debian:buster-slim

# pre-reqs
RUN set -ex \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    gnupg \
    gstreamer1.0-plugins-bad \
    python3-pip \
  && rm -rf /var/lib/apt/lists/*

# install mopidy with apt extensions
RUN set -ex \
  && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
  && curl -L https://apt.mopidy.com/buster.list -o /etc/apt/sources.list.d/mopidy.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mopidy \
    mopidy-mpd \
  && rm -rf /var/lib/apt/lists/*

# install additional (non apt) extensions
RUN set -ex \
  && pip3 install mopidy-ytmusic

# config location
RUN mkdir -p /config /mopidy/.config \
  && chown mopidy:audio /config \
  && chown -R mopidy:audio /mopidy \
  && ln -s /config /mopidy/.config/mopidy
ENV HOME=/mopidy

EXPOSE 6600 6680

USER mopidy

CMD /usr/bin/mopidy 2>&1
