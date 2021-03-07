#!/bin/bash

PODMAN=$(which podman)
IMAGE="zucchini-qemu:latest"

if [ $# -lt 1 ] || [ ! -f ${1} ]
then
  echo "Need config file."
  exit 1
fi

source ./${1}

${PODMAN} run --rm -d -it --name ${NAME} --privileged \
  -v $(pwd)/${1}:/config \
  ${VOLUMES[*]} \
  ${SERVICES[*]} \
  ${IMAGE}
