# Overview

This is a minimal and simple git remote for hosting and sharing git-repositories.
The remote repositories is accesssed through SSH (push/pull). It's possible to
initialize and list all repositoris using git-shell through SSH.

## Versions

* `1nfiniteloop/git-remote:latest` from
  [here](https://github.com/1nfiniteloop/git-remote).

## Volumes

* `/srv/git`

## Ports

* 22

## Environment variables

* AUTHORIZED_KEYS

## Usage

1. Start container:

        docker run \
          --name=git-remote \
          --detach \
          --publish 0.0.0.0:8022:22 \
          --volume git:/srv/git \
          --volume git-hostkeys:/etc/ssh \
          --env "AUTHORIZED_KEYS=$(cat authorized_keys.d/*.pub)" \
          1nfiniteloop/git-remote:latest

2. Initialize a repository on the git-remote with `ssh git@your-domain.com`

        git> init hello-world

3. Clone the empty repository with
   `git clone git@your-domain.com:/srv/git/hello-world.git`.
