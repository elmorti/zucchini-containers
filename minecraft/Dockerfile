FROM openjdk:8-alpine

RUN apk add \
  bash \
  shadow

SHELL ["/bin/bash", "-c"]

ARG FLAVOR=spigot
ARG VERSION=1.12.2

RUN \
  useradd -u 1000 -U -m -s /bin/false minecraft && \
  mkdir -p /home/minecraft/{bin,jar} && \
  mkdir -p /data && \
  chown -R minecraft:minecraft /data

COPY scripts/start.sh /home/minecraft/bin
COPY jarfiles/minecraft/${FLAVOR}/${VERSION}/${FLAVOR}-${VERSION}.jar /home/minecraft/jar/server.jar

RUN \
  chown -R minecraft:minecraft /home/minecraft

VOLUME ["/data"]

COPY --chown=minecraft:minecraft config/server.properties /data

WORKDIR /data

ENV \
  SERVER_PORT=25565 \
  LEVEL_NAME=main \
  MAX_PLAYERS=100 \
  MOTD= \
  QUERY_PORT= \
  RCON_PORT=

ENV \ 
  JAVA_XMS=-Xms1024m \
  JAVA_XMX=-Xmx1024m
ENV \
  JAVA_EXTRA \
    -XX:+UseG1GC \
    -XX:+UnlockExperimentalVMOptions \
    -XX:MaxGCPauseMillis=100 \
    -XX:+DisableExplicitGC \
    -XX:TargetSurvivorRatio=90 \
    -XX:G1NewSizePercent=50 \
    -XX:G1MaxNewSizePercent=80 \
    -XX:G1MixedGCLiveThresholdPercent=35 \
    -XX:+AlwaysPreTouch \
    -XX:+ParallelRefProcEnabled \
    -Dusing.aikars.flags=mcflags.emc.gs

USER minecraft

ENTRYPOINT ["/home/minecraft/bin/start.sh"]
