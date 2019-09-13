# opencanary
## opencanary in a docker container

This is a simple docker iomage to run opencanary and keeping its weird dependencies contained.

I am using python-alpine to minimize the image size.

I am installing dev dependencies in the builder image to minimize the image size.

I am patching inotify to fix the stupoid alpine find_library bug.

I am running opencanary in foreground, so that container dies when opencanary dies.

I recommend running it as detached container with autorestart:

```bash
docker run \
  --net=host \      # use host network, no need to be shy
  --name=canary \   # let us call it canary 
  -v /etc/opencaanary/opencanary.conf:/opencanary.conf \ # map the config file 
  --restart=always \ # restart on reboot or on failure
  -d \              # detach 
  avi0/opencanary:0.1

docker logs -f canary # display the logs on console; safe to terminate
```
Note: for Raspbery Pi 3b use avi0/opencanary:0.1-arm32v7 tag