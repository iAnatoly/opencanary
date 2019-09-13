#!/bin/sh
NAME='canary'
docker stop $NAME
docker rm $NAME
docker run \
  --net=host \
  --name=$NAME \
  -v /etc/opencanary/opencanary.conf:/opencanary.conf \
  --restart=always \
  -d \
  avi0/opencanary:0.1
docker logs -f $NAME
