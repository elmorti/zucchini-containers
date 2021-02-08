FROM alpine:3.8

RUN apk add --no-cache \
    bash       \
    curl       \
    ipvsadm    \
    iproute2   \
    keepalived \
 && mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.orig

ADD keepalived.conf /etc/keepalived

CMD ["/bin/bash","-l"]
