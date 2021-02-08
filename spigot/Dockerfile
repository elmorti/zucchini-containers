FROM elmorti/zucchini-openjdk:latest

ARG VERSION=latest

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
    -Dusing.aikars.flags=mcflags.emc.gs \
    -XX:+UseCGroupMemoryLimitForHeap

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

ENTRYPOINT [ "/usr/bin/java", "-jar", "BuildTools.jar" ]
CMD [ "--rev", "$VERSION", "--output-dir", "/output" ]
