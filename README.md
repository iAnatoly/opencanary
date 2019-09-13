# opencanary
## Minimalistic opencanary in a docker container

This is a minimalistic docker image to run opencanary and keeping its weird dependencies contained.

Main design principles:

1. Minimalistic base image (python2.7-alipine)
2. Exclusion of build dependencoies from production image
3. Only necessary processes - run opencanaryd in foreground

Notable hacks:

1. I am patching inotify to fix the stupid alpine find_library bug (small prioce to pay for the image size)
2. I include a default config in /root/.opencanary.conf, in case a user is too lazy to provide a customized config file. I highly recommend providing a customized config file with external logging/alerting, but I guess it is OK to use a default as a POC.
3. The image is only supported on two architectures - arm32v7 (Raspbery Pi 3b), and amd x86_64. It is fairly easy to build it for other architectures, but I do not use other architectures, so I did not.

I recommend running the image as detached container with autorestart:

```bash
docker run \
  --net=host \      # use host network, no need to be shy
  --name=canary \   # let us call it canary 
  -e TZ=US/Pacific \ # set the timezone correctly
  -v /etc/opencanary/opencanary.conf:/opencanary.conf \ # map the config file. Make sure the file is actually there. 
  --restart=always \ # restart on reboot or on failure
  -d \              # detach 
  avi0/opencanary:0.1

docker logs -f canary # display the logs on console; safe to terminate
```
Note: for Raspbery Pi 3b use avi0/opencanary:0.1-arm32v7 tag
