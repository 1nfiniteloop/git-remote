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
    mkdir ~git/shared && \
    echo "export GIT_REPO_PATH=~git/shared" > ~git/.gitrc && \
    chown -R git:git ~git

VOLUME /home/git/shared
EXPOSE 22
CMD ["/bin/s6-svscan", "/etc/s6"]
