#!/bin/bash

if [ ! -f /config ]
then
  echo "Can't find config file."
  exit 1
fi

source ./config

${EMULATOR} ${QEMUOPTS[*]}
