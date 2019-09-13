# opencanary
## opencanary in a docker - starting fresh to avoid garbage

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
  iAnatoly/opencanary:latest

docker logs -f canary # display the logs on console; safe to terminate
```
