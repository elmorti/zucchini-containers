FROM openjdk:12-alpine

ENV APK="apk --no-cache"

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

ENV GIT_EMAIL="something@something.com" \
    GIT_USER="someone"

RUN ${APK} update && ${APK} add bash curl git maven patch \
  && adduser -g "Zucchini Universe" -s /bin/bash -D -u 1305 zucchini

USER zucchini

WORKDIR /home/zucchini

RUN git config --global user.email "$GIT_EMAIL" && git config --global user.name "$GIT_USER"

ENTRYPOINT [ "/bin/bash" ]
