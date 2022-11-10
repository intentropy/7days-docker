FROM    ubuntu:latest

#COPY    src/etc/apt/sources.list                /etc/apt/sources.list
COPY    src/usr/bin/config_7days.py             /usr/bin/config_7days
COPY    src/usr/bin/entrypoint.sh               /usr/bin/entrypoint
COPY    src/usr/bin/startserver_keepalive.sh    /usr/bin/startserver_keepalive.sh

RUN \
    apt update && \
    apt upgrade -y && \
    apt install -y software-properties-common && \
    dpkg --add-architecture i386 && \
    add-apt-repository multiverse -y && \
    apt update && \
    apt install -y --no-install-recommends \
        libterm-readline-gnu-perl \
        apt-utils \
        lib32gcc-s1 \
        lib32stdc++6 \
        libc6-i386 \
        libcurl4-gnutls-dev:i386 \
        libsdl2-2.0-0:i386 \
        curl \
        python3 \
        python3-xmltodict \
        vim \
        procps \
        anacron && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt install -y steamcmd && \
    PATH="$PATH:/usr/games" && \
    steamcmd +login anonymous +app_update 294420 +quit && \
    ln -s '/root/Steam/steamapps/common/7 Days to Die Dedicated Server' /7days_data && \
    ln -s /root/.local/share/7DaysToDie /7days_saves && \
    ln -s /7days_data /7days


VOLUME /root/.local/share/7DaysToDie

ENTRYPOINT [ "entrypoint" ]
#ENTRYPOINT [ "bash" ]