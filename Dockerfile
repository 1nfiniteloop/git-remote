FROM 1nfiniteloop/alpine:latest

RUN apk update \
    && apk add --no-cache \
      git \
      openssh-server \
    && rm -r /var/cache/apk/*

COPY overlay /

ARG GIT_STORAGE_PATH=/srv/git

RUN git config --system init.defaultBranch main \
  && adduser \
      -D \
      -s /usr/bin/git-shell \
      git \
    && echo "git:*" | chpasswd -e &> /dev/null \
    && mkdir ${GIT_STORAGE_PATH} \
    && echo "GIT_STORAGE_PATH=${GIT_STORAGE_PATH}" > ~git/.git-shell \
    && chown -R git:git ~git ${GIT_STORAGE_PATH}

VOLUME ${GIT_STORAGE_PATH}
EXPOSE 22
CMD ["/bin/s6-svscan", "/etc/services.d"]
