#!/bin/bash

podman run -it --pod zucchini-panel --name nginx \
	-v $(pwd)/certs:/home/zucchini/certs \
	-v $(pwd)/conf/nginx/nginx.conf:/etc/nginx/nginx.conf \
	-v $(pwd)/conf/nginx/conf.d:/etc/nginx/conf.d \
	-v $(pwd)/sites:/www \
	-v zucchini-panel-app:/home/zucchini/panel \
	zucchini-nginx:latest
