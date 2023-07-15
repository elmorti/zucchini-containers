#!/bin/bash

PODMAN=$(which podman)
IMAGE="grafana:latest"

if [ $# -lt 1 ] || [ ! -f ${1} ]
then
  echo "Need config file."
  exit 1
fi

source $(realpath ${1})

${PODMAN} run --rm -it --name ${NAME} \
  -v $(realpath ${1}):/config \
  ${VOLUMES[*]} \
  ${SERVICES[*]} \
  ${IMAGE}
