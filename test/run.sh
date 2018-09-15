#!/bin/bash
# f5-ansible - Run Tests
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.5, 16/09/2018

set -xeo pipefail

REPO="artioml/f5-ansible"

# Linting
for file in */*.yml; do echo "$file"; python -c 'import yaml,sys; yaml.safe_load(sys.stdin)' < "$file"; done

# Ansible check mode
str_TEST="ansible --version; \
	ansible-playbook playbooks/*app.yml playbooks/cmd.yml playbooks/pmem.yml --syntax-check; \
	ansible-playbook playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | awk '/bigips/{getline; print}'); \
	touch playbooks/f5.http.yml; \
	ansible-playbook playbooks/iapp.yml -e @creds.yml --vault-password-file .password --check; \
	./runsible.py --help;"

if [ "$TRAVIS" == "true" ]; then
	docker run $REPO /bin/sh -c "$str_TEST"
	docker run $REPO:dev /bin/sh -c "$str_TEST"
else
	eval "$str_TEST"
fi
