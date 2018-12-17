FROM 1nfiniteloop/alpine:latest

RUN apk update && \
    apk add --no-cache \
    git \
    openssh-server

COPY rootfs /

RUN adduser -D \
        -u 1000 \
        -s /usr/bin/git-shell git && \
    echo "git:git" | chpasswd &> /dev/null && \
    mkdir /srv/git && \
    echo "export GIT_REPO_PATH=/srv/git" > ~git/.gitrc && \
    chown -R git:git ~git /srv/git

VOLUME /srv/git
EXPOSE 22
CMD ["/bin/s6-svscan", "/etc/s6"]
