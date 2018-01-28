#!/bin/bash
set -xe
set -o pipefail

REPO="artioml/f5-ansible"
HOST=$(cat inventory/hosts | sed -n '2{p;q}')

docker run -u0 $REPO /bin/sh -c 'rm -f ansible.cfg; ansible-playbook -i inventory/hosts playbooks/app.yml --list-hosts | grep $HOST'
docker run -u0 $REPO:dev /bin/sh -c 'rm -f ansible.cfg; ansible-playbook -i inventory/hosts playbooks/app.yml --list-hosts | grep $HOST'
