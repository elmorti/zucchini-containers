#!/bin/bash -

# Clean Aliases
\unalias -a

# Clean Bash memory for binaries
\hash -r

# No core dumps -> Should not this be handled by cgroups?
# ulimit -H -c 0 -- 

# Clean PATH
export PATH=$(getconf PATH)

joinOptions()
{
  local -n OPTSARRAY=$1
  echo $(IFS=',' && printf "${OPTSARRAY[*]}")
}

source ./pod.config

CMD="
  podman pod create \
    --hostname=${PODNAME} \
    --name=${PODNAME} \
    --network=${NETWORK}:$(joinOptions SLIRP4NETNS) \
    ${SERVICES[*]}
  
"

echo ${CMD}
# printf "%s\n" ${CMD[*]}
