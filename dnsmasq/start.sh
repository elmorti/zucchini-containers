#!/bin/bash

podman run --rm \
  --name dnsmasq \
  -it \
  -v $(pwd)/config/dnsmasq.conf:/etc/dnsmasq.conf:Z \
  -v $(pwd)/config/dnsmasq.d:/etc/dnsmasq.d:Z \
  -p 53:53/udp -p 53:53/tcp \
  zucchini-dns:dev
