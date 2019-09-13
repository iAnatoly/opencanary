#!/bin/sh
NAME='canary'
docker stop $NAME
docker rm $NAME
docker run \
  --net=host \
  --name=$NAME \
  -e TZ=US/Pacific \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/opencanary/opencanary.conf:/opencanary.conf:ro \
  --restart=always \
  -d \
  avi0/opencanary:0.2
docker logs -f $NAME
