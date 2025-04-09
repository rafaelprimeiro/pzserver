FROM openjdk:25-ea-17-jdk-slim

ARG PZ_DIR=/opt/project_zomboid
ARG PZ_SERVER_DIR=$PZ_DIR/Server
ARG PZ_USER_HOME=/root/Steam
ARG PZ_SERVERNAME="dedicated_server"
ARG PZ_ADMIN_USERNAME="BobAdmin"
ARG PZ_ADMIN_PASSWORD="dropkick-MADMAN"

ENV SERVER_NAME=$PZ_SERVERNAME
ENV ADMIN_USERNAME=$PZ_ADMIN_USERNAME
ENV ADMIN_PASSWORD=$PZ_ADMIN_PASSWORD

RUN mkdir -p $PZ_SERVER_DIR

RUN apt-get clean && apt-get update

RUN apt-get install -y \
    wget \
    unzip \
    lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $PZ_USER_HOME && \
    cd $PZ_USER_HOME && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

RUN cd $PZ_USER_HOME && ./steamcmd.sh +login anonymous +force_install_dir $PZ_SERVER_DIR +app_update 380870 validate +quit

COPY ./game_default /root/Zomboid/Server
COPY ./ProjectZomboid64.json $PZ_SERVER_DIR/ProjectZomboid64.json
COPY ./lauch_server.sh $PZ_SERVER_DIR/lauch_server.sh

RUN chmod +x $PZ_SERVER_DIR/lauch_server.sh

EXPOSE 16261/udp 16262/udp 8766/udp 8767/udp

WORKDIR /root/Zomboid

ENTRYPOINT ["/bin/bash", "-c", "/opt/project_zomboid/Server/lauch_server.sh"]