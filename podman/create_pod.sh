#!/bin/bash

POD_CONFIGFILE="pod.config"

PODMAN=$(which podman)

if [ -z ${PODMAN} ]
then
    echo "Cannot find podman." && exit 1
fi

function usage() {
    echo "Usage:"
    echo ""
    echo ${0} config_dir
    echo ""
    echo "config_dir: Should contain pod and container configuration files."
    echo ""
    exit 1
}

if [ ${#} -lt 1 ]
then
  usage
fi

if [ ! -d ${1} ]
then
  echo "Directory ${1} does not exist." && exit 1
fi

if [ ! -f ${1}/${POD_CONFIGFILE} ]
then
  echo "Can't find ${1}/${POD_CONFIGFILE}." && exit 1
fi

source $(realpath ${1}/${POD_CONFIGFILE})
if [ $? -ne 0 ]
then
  echo "Something went wrong importing the config." && exit 1
fi

$PODMAN pod create --hostname ${PODNAME} \
 --infra \
 --name ${PODNAME} \
 ${SERVICES[*]} \
 --network=${NETWORK} \
 --replace

CONTAINERS=$(ls -1 ${1}/*.container.config)

for CONFIG in ${CONTAINERS}
do
  source $(realpath ${CONFIG})
  ${PODMAN} container create --pod ${PODNAME} \
    --security-opt=label=disable \
    ${MOUNTS[*]} \
    ${ENV[*]} \
    ${CTR_EXTRA[*]} \
    --name ${CONTAINER} \
    ${IMAGE}

  if [ ! $? -eq 0 ]
  then
    printf "Container failed, removing everything..."
    ${PODMAN} pod rm -f ${PODNAME}
    exit 1
  fi
done
