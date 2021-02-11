#!/bin/bash

PODMAN=$(which podman)

if [ ! -f $(pwd)/dev.config ]
then
  echo "Cannot find dev.config file."
  exit 1
fi

source $(pwd)/dev.config

echo "Creating the pod ${PODNAME}..."

$PODMAN pod create --hostname ${PODNAME} --infra \
  --name ${PODNAME} \
  -p ${PHP_PORT}:9000/tcp \
  -p ${HTTP_PORT}:80/tcp --replace

echo "Adding the containers to the pod..."

$PODMAN create -d --pod ${PODNAME} \
  -v ${DB_VOLUME}:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  -e MYSQL_PASSWORD=${MYSQL_PASSWORD} \
  -e MYSQL_DATABASE=${MYSQL_DATABASE} \
  -e MYSQL_USER=${MYSQL_USER} \
  --name mariadb mariadb:latest

$PODMAN create -d --pod ${PODNAME} \
  -v ${REDIS_VOLUME}:/data \
  --name redis redis:alpine

$PODMAN create -d -t --pod ${PODNAME} \
  -v ${APP_VOLUME}:/home/zucchini/panel \
  -v ${LOGS_VOLUME}:/home/zucchini/logs \
  --name panel zucchini-panel:latest

podman create -d --pod ${PODNAME} \
  -v ${NGINX_CONF}/nginx.conf:/etc/nginx/nginx.conf \
  -v ${NGINX_CONF}/conf.d:/etc/nginx/conf.d \
  -v ${APP_VOLUME}:/home/zucchini/panel \
  --name nginx zucchini-nginx:latest

echo "Pod and containers created - Start with podman pod start ${PODNAME}"
echo ""
echo "Don't forget to initialize the panel data."
echo ""
echo "And then use supervisorctl start all."
