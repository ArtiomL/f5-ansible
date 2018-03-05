#!/bin/bash
# f5-ansible - Run Tests
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.1, 04/02/2018

set -xe
set -o pipefail

REPO="artioml/f5-ansible"

docker run $REPO /bin/sh -c 'ansible-playbook playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | sed -n 2p)'
docker run $REPO:dev /bin/sh -c 'ansible-playbook playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | sed -n 2p)'
