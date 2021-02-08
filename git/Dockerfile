FROM alpine:latest

LABEL maintainer Zucchini Universe <zucchini@zucchiniuniverse.org>

RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk add --no-cache bash git

VOLUME /workdir
WORKDIR /workdir

ENTRYPOINT [ "/usr/bin/git" ]
