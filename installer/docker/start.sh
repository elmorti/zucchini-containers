#!/bin/bash

docker run --rm \
  --name dnsmasq \
  -it \
  --net=host \
  --privileged \
  -v $(pwd)/config/dnsmasq/dnsmasq.conf:/etc/dnsmasq.conf:Z \
  -v $(pwd)/config/dnsmasq/dnsmasq.d:/etc/dnsmasq.d:Z \
  -v $(pwd)/config/tftp/pxelinux.cfg:/var/tftpboot/pxelinux.cfg:Z \
  -v $(pwd)/sources:/var/tftpboot/sources:Z \
  zucchini-dnsmasq:latest
