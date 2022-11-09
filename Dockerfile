FROM    debian:latest

COPY    src/etc/apt/sources.list                /etc/apt/sources.list
COPY    src/usr/bin/config_7days.py             /usr/bin/config_7days
COPY    src/usr/bin/entrypoint.sh               /usr/bin/entrypoint
COPY    src/usr/bin/startserver_keepalive.sh    /usr/bin/startserver_keepalive.sh

RUN \
    apt update && \
    apt upgrade -y && \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y \
        lib32gcc-s1 \
        curl \
        python3 \
        python3-xmltodict \
        vim \
        procps \
        anacron && \
    mkdir steam && \
    cd steam && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | \
        tar zxvf - && \
    mkdir -p /root/.local/share/7DaysToDie && \
    ./steamcmd.sh +login anonymous +app_update 294420 +quit && \
    ln -s '/root/Steam/steamapps/common/7 Days to Die Dedicated Server' /7days_data && \
    ln -s /root/.local/share/7DaysToDie /7days_saves && \
    mkdir -p /7days_saves/Logs && \
    ln -s /7days_data /7days

VOLUME /root/.local/share/7DaysToDie

ENTRYPOINT [ "entrypoint" ]