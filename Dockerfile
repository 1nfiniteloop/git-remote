FROM 1nfiniteloop/alpine:latest

RUN apk update \
    && apk add --no-cache \
      git \
      openssh-server \
    && rm -r /var/cache/apk/*

COPY rootfs /

ARG GIT_STORAGE_PATH=/srv/git

RUN adduser \
      -D \
      -s /usr/bin/git-shell \
      git \
    && echo "git:git" | chpasswd &> /dev/null \
    && mkdir ${GIT_STORAGE_PATH} \
    && chown -R git:git ~git ${GIT_STORAGE_PATH} \
    && echo "GIT_STORAGE_PATH=${GIT_STORAGE_PATH}" > ~git/.git-shell

VOLUME ${GIT_STORAGE_PATH}
EXPOSE 22
CMD ["/bin/s6-svscan", "/etc/s6"]
