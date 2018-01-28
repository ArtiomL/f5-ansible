#!/bin/bash
set -xe
set -o pipefail

REPO="artioml/f5-ansible"

docker run -u0 $REPO /bin/sh -c 'rm -f ansible.cfg; ansible-playbook -i inventory/hosts playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | sed -n 2p)'
docker run -u0 $REPO:dev /bin/sh -c 'rm -f ansible.cfg; ansible-playbook -i inventory/hosts playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | sed -n 2p)'
