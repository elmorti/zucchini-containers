#!/bin/bash

if [ ! -f /config ]
then
  echo "Can't find config file."
  exit 1
fi

source ./config

qemu-system-x86_64 ${QEMUOPTS[*]}
