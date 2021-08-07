FROM 1nfiniteloop/alpine:1.0

RUN apk update \
    && apk add --no-cache \
      git \
      openssh-server \
      tree \
    && rm -r /var/cache/apk/*

COPY overlay /

RUN git config --system init.defaultBranch main \
    && adduser \
        -D \
        -s /usr/bin/git-shell \
        git \
    && echo "git:*" | chpasswd -e &> /dev/null \
    && ln -s /etc/git-shell-commands /home/git/git-shell-commands

VOLUME /home/git

EXPOSE 22
CMD ["/bin/s6-svscan", "/etc/services.d"]
