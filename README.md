# Overview

This is a minimal and simple git remote for hosting and sharing git-repositories.
The remote repositories is accesssed through SSH (push/pull). It's possible to
initialize and list all repositoris using git-shell through SSH.

## Versions

* `1nfiniteloop/git-remote:latest` from
  [here](https://github.com/1nfiniteloop/git-remote).

## Volumes

* /srv/git

## Ports

* 22

## Environment variables

* AUTHORIZED_KEYS

## Author

[Lars Gunnarsson](https://github.com/1nfiniteloop)

## License

MIT

## Usage

1. Provide the login ssh-keys for the user *git* with e.g. 
   `export AUTHORIZED_KEYS=$(cat ~/.ssh/my-git-remote.com/*.pub)`
2. Start container:
```bash
 docker run \
    --name=git-remote \
    --detach \
    --publish 0.0.0.0:8022:22 \
    --volume git:/srv/git \
    --env=AUTHORIZED_KEYS \
    1nfiniteloop/git-remote:latest
```
3. Initialize a repository on the git-remote with `ssh git@my-git-remote.com`
```bash
git> init hello-world
```
4. Clone the empty repository with
   `git clone my-git-remote.com:shared/hello-world.git`.
