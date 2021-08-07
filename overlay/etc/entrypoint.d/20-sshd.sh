#!/bin/bash

readonly host_keys_path="/etc/ssh/host_keys"

# Create host keys, if they don't exist
if [[ ! -d ${host_keys_path} ]] || [[ ! "$(ls ${host_keys_path})" ]]; then
  # Can't control absolute path when generating host-keys,
  # only prefix path.
  mkdir -p "${host_keys_path}" \
    && mkdir -p /tmp/etc \
    && ln -s "${host_keys_path}" /tmp/etc/ssh \
    && ssh-keygen -f /tmp -A \
    && rm -r /tmp/etc
fi
