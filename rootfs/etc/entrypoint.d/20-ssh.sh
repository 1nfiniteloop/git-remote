#!/bin/bash

# Environment variables in
# AUTHORIZED_KEYS

# Configuration
readonly SSH_USER=git

# Constants
readonly AUTHORIZED_KEYS_FILE=/home/${SSH_USER}/.ssh/authorized_keys
readonly AUTHORIZED_KEYS_NO=$(echo "${AUTHORIZED_KEYS}" | wc -l)


function authorized_keys_not_exist() {
    local auth_keys_file=$1
    [ ! -e ${auth_keys_file} ]
    return
}

function create_authorized_keys() {
    local ssh_user=$1
    local auth_keys_file=$2
    local auth_keys_path=$(dirname $2)
    ([ -e ${auth_keys_path} ] || \
        mkdir -m 700 ${auth_keys_path}) && \
    ([ -e ${auth_keys_file} ] || \
        (touch ${auth_keys_file} && \
            chmod 600 ${auth_keys_file})) && \
    chown -R ${ssh_user}:${ssh_user} ${auth_keys_path}
}

function add_authorized_keys() {
    local auth_keys_file=$1
    local auth_keys=$2
    echo "${auth_keys}" >> ${auth_keys_file}
    # TODO: echo -n "no-agent-forwarding,no-port-forwarding,no-X11-forwarding " >> .ssh/authorized_keys
}

[ -n "${AUTHORIZED_KEYS}" ] && \
    authorized_keys_not_exist ${AUTHORIZED_KEYS_FILE} && \
    create_authorized_keys ${SSH_USER} ${AUTHORIZED_KEYS_FILE} && \
    add_authorized_keys ${AUTHORIZED_KEYS_FILE} "${AUTHORIZED_KEYS}" && \
    echo "Added ${AUTHORIZED_KEYS_NO} key(s) to authorized_keys for user ${SSH_USER}."

