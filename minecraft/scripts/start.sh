#!/bin/bash

WORKDIR=/data
USER=minecraft

if [ ! -d ${WORKDIR} ]
then
  echo "ERR: Workdir ${WORKDIR} does not exists."
  exit 1
fi

if [ ! -f ${WORKDIR}/server.properties ]
then
  echo "ERR: server.properties not found"
  exit 1
fi

echo "eula=true" > ${WORKDIR}/eula.txt

exec java ${JAVA_XMS} ${JAVA_XMX} ${JAVA_EXTRA} -jar /home/minecraft/jar/server.jar
