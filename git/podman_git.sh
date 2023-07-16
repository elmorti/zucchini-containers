#!/bin/bash

IMAGE="zucchini-git"
VERSION="latest"

# man podman-run to customize this - label=disable is fine as we want
# to run "git" as a command, so it won't be confined as a container_t
# this is intended to mount home as /root
SECURITY_OPT="--security-opt label=disable"                                                                 
EXPOSE_SSH_AGENT="-v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent"

PODMAN=$(whereis podman | cut -d' ' -f2)
if [ ! -x ${PODMAN} ]
then
  echo "podman not found... exiting"
  exit 1
fi

# ${PODMAN} run ${SECURITY_OPT} -it --rm ${EXPOSE_SSH_AGENT} -v ${HOME}:/root -v $(pwd):/workdir ${IMAGE}:${VERSION} "$@"
echo "${PODMAN} run ${SECURITY_OPT} -it --rm ${EXPOSE_SSH_AGENT} -v ${HOME}:/root -v $(pwd):/workdir ${IMAGE}:${VERSION}"
