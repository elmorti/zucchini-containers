#!/bin/bash

ELASTICSEARCH_CONTAINER_NAME="elasticsearch"
KIBANA_CONTAINER_NAME="kibana"

ELASTICSEARCH_CONFIG="$(pwd)/config/elasticsearch/elasticsearch.yml"
ELASTICSEARCH_DATA="$(pwd)/data/elasticsearch"
ELASTICSEARCH_OPTIONS="--ulimit nofile=65535:65535"
ELASTICSEARCH_IMAGE="zucchini-elasticsearch:7.4.2"

KIBANA_CONFIG="$(pwd)/config/kibana/kibana.yml"
KIBANA_DATA="$(pwd)/data/kibana"
KIBANA_OPTIONS=""
KIBANA_IMAGE="zucchini-kibana:7.4.2"

OWNER_UID=1305
OWNER_GID=1305

STACK_NETWORK="elastic0"

main() {
  if [ "$(stat --format %u ${ELASTICSEARCH_DATA})" != "${OWNER_UID}" ] || \
     [ "$(stat --format %u ${KIBANA_DATA})" != "${OWNER_UID}" ]
  then
    echo "Check data permissions."
    exit 1
  fi

  if [ "$1" == "start" ]
  then
    create_elastic_network
    run_elastic_search
    run_kibana
    exit $?
  fi

  if [ "$1" == "stop" ]
  then
    docker kill ${ELASTICSEARCH_CONTAINER_NAME} ${KIBANA_CONTAINER_NAME}
    docker rm ${ELASTICSEARCH_CONTAINER_NAME} ${KIBANA_CONTAINER_NAME}
    docker network rm ${STACK_NETWORK}
    exit $?
  fi

  echo "start or stop"
  exit 1
}

run_elastic_search() {
  docker run -d --name ${ELASTICSEARCH_CONTAINER_NAME} \
    -p 9200:9200 -p 9300:9300 \
    ${ELASTICSEARCH_OPTIONS} \
    -e "discovery.type=single-node" \
    -v ${ELASTICSEARCH_DATA}:/usr/share/elasticsearch/data \
    --network=${STACK_NETWORK} \
    --hostname=${ELASTICSEARCH_CONTAINER_NAME} \
  ${ELASTICSEARCH_IMAGE}
}

run_kibana() {
  docker run -d --name ${KIBANA_CONTAINER_NAME} \
   -p 5601:5601 \
   --network=${STACK_NETWORK} \
   --hostname=${KIBANA_CONTAINER_NAME} \
  ${KIBANA_IMAGE}
}

create_elastic_network() {
  docker network create \
    --driver=bridge \
    --subnet=172.28.0.0/16 \
    --ip-range=172.28.5.0/24 \
    --gateway=172.28.5.254 \
  ${STACK_NETWORK}
}

main $1
