#!/bin/sh
NAME='canary'
docker stop $NAME
docker rm $NAME
docker run \
  --net=host \
  --name=$NAME \
  -e TZ=US/Pacific \
  -v /etc/opencaanary/opencanary.conf:/opencanary.conf \
  --restart=always \
  -d \
  opencanary:latest
docker logs -f $NAME
