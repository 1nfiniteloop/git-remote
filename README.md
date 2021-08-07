# Overview

This is a minimal and simple git remote for hosting and sharing git-repositories.
The remote repositories is accesssed through SSH (push/pull). It's possible to
initialize and list all repositoris using git-shell through SSH.

## Versions

* `1nfiniteloop/git-remote:latest` from
  [here](https://github.com/1nfiniteloop/git-remote).

## Volumes

* `/home/git`

## Ports

* 22

## Environment variables

_None_

## Usage

1. Start container:

        docker run \
          --name=git-remote \
          --detach \
          --publish 0.0.0.0:8022:22 \
          --volume git-remote.home:/home/git \
          --volume git-remote.host-keys:/etc/ssh/host_keys \
          1nfiniteloop/git-remote:latest

2. Add authorized ssh keys:

        docker exec -it git-remote mkdir /home/git/authorized_keys
        docker cp authorized_keys/*.pub git-remote:/home/git/authorized_keys

3. Initialize a repository on the git-remote with `ssh git@your-domain.com`

        git> init hello-world

4. Clone the empty repository with

        git clone git@your-domain.com:hello-world.git
