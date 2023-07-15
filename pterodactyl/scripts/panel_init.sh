#!/bin/bash

PODMAN=$(which podman)

if [ ! -f $(pwd)/dev.config ]
then
  echo "Cannot find dev.config file."
  exit 1
fi

source $(pwd)/dev.config

${PODMAN} exec panel php artisan p:environment:setup -n \
  --author=${APP_SERVICE_AUTHOR} \
  --url=${APP_URL} \
  --timezone=${APP_TIMEZONE} \
  --cache=${CACHE_DRIVER} \
  --session=${SESSION_DRIVER} \
  --queue=${QUEUE_CONNECTION} \
  --redis-host=${REDIS_HOST} \
  --redis-port=${REDIS_PORT} \
  --redis-pass=${REDIS_PASSWORD} \
  --settings-ui=${APP_ENVIRONMENT_ONLY} \
  --new-salt

${PODMAN} exec panel php artisan p:environment:mail -n \
  --driver=${MAIL_DRIVER} \
  --email=${MAIL_FROM} \
  --from="${MAIL_FROM_NAME}"

${PODMAN} exec panel php artisan p:environment:database -n \
  --host=${DB_HOST} \
  --port=${DB_PORT} \
  --database=${DB_DATABASE} \
  --username=${DB_USERNAME} \
  --password=${DB_PASSWORD}

${PODMAN} exec panel php artisan migrate --seed --force

${PODMAN} exec panel php artisan p:user:make -n \
  --email=${ADMIN_EMAIL} \
  --username=${ADMIN_USERNAME} \
  --name-first=${ADMIN_FIRSTNAME} \
  --name-last=${ADMIN_LASTNAME} \
  --password=${ADMIN_PASSWORD} \
  --admin=1
