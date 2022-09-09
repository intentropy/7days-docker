FROM    debian:latest

COPY    src/etc/apt/sources.list    /etc/apt/sources.list
COPY    src/usr/bin/config_7days.py /usr/bin/config_7days
COPY    src/usr/bin/entrypoint.sh   /usr/bin/entrypoint

RUN \
    apt update && \
    apt upgrade -y && \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y \
        lib32gcc-s1 \
        curl \
        python3 \
        python3-xmltodict && \
    mkdir steam && \
    cd steam && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | \
        tar zxvf - && \
    ./steamcmd.sh +login anonymous +app_update 294420 +quit

ENTRYPOINT [ "entrypoint" ]