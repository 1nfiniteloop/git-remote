#!/bin/bash

# Environment variables:
# AUTHORIZED_KEYS

readonly SSH_USER=git
readonly AUTHORIZED_KEYS_FILE=/home/${SSH_USER}/.ssh/authorized_keys


if [[ -n "${AUTHORIZED_KEYS}" ]] && [[ ! -s ${AUTHORIZED_KEYS_FILE} ]]; then
  echo "${AUTHORIZED_KEYS}" >> ${AUTHORIZED_KEYS_FILE} \
    && echo "Added $(wc -l <<< "${AUTHORIZED_KEYS}") ssh key(s) for user ${SSH_USER}."
fi

# Create host keys, if not extsts
ssh-keygen -A
