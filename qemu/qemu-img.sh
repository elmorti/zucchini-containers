#!/bin/bash

PODMAN=$(which podman)
IMAGE="zucchini-qemu:latest"

${PODMAN} run --rm -it --security-opt=label=disable --name qemu-img --entrypoint /bin/bash -v $(pwd):/images ${IMAGE}
