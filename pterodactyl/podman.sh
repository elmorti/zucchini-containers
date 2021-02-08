#!/bin/bash

PODMAN=$(which podman)
PODNAME="zucchini-panel"

$PODMAN run -d -t --pod ${PODNAME} \
    -v zucchini-panel-app:/home/pikachu/panel \
    -v zucchini-panel-logs:/home/pikachu/logs \
    -v $(pwd)/conf/panel/pikachu-panel-dev.env:/home/pikachu/panel/.env \
    --name panel zucchini-panel:latest
