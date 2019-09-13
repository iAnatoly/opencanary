FROM python:2.7-alpine as base
# yes, I know. The moment opencanary starts supporting python3, i am upgrading
MAINTAINER iAnatoly, https://github.com/iAnatoly

FROM base as base-with-gcc

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev openssl-dev

FROM base-with-gcc as python-builder

RUN mkdir /install

WORKDIR /install

RUN pip install --install-option="--prefix=/install" opencanary

FROM base

RUN apk add --no-cache openssl libffi bash sudo tzdata

COPY --from=python-builder /install /usr/local

#fix stupid alpine linux bug
RUN sed -i -e "s/ctypes\.util\.find_library('c')/'$(ls /lib | grep libc.musl)'/g" /usr/local/lib/python2.7/site-packages/twisted/python/_inotify.py

# copy over a failback config file with reasonable defaults:
COPY opencanary.conf /root/.opencanary.conf

# mount opencacary.conf in / to override the default config
WORKDIR /

# run in foreground, to capture logs in docker 
CMD ["/usr/local/bin/opencanaryd", "--dev"]
