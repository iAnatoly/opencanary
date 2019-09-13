#!/bin/sh
docker stop opencanary
docker rm opencanary
docker run \
  --net=host \
  --name=canary \
  -e TZ=US/Pacific \
  -v /etc/opencaanary/opencanary.conf:/opencanary.conf \
  --restart=always \
  -d \
  opencanary:latest
docker logs -f opencanary
