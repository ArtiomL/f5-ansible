#!/bin/bash
# f5-ansible - Run Tests
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.7, 18/10/2018

set -xeo pipefail

REPO="artioml/f5-ansible"

# Linting
str_TEST="yamllint -c test/lint.yml */*.yml;"

# Ansible check mode
str_TEST="$str_TEST ansible --version; \
	ansible-playbook $(ls -1 playbooks/*.yml | grep -v 'task' | tr '\n' ' ') --syntax-check; \
	ansible-playbook playbooks/app.yml --list-hosts | grep $(cat inventory/hosts | awk '/bigips/{getline; print}'); \
	touch playbooks/f5.http.yml; \
	ansible-playbook playbooks/iapp.yml -e @creds.yml --vault-password-file .password --check; \
	./runsible.py --help;"

if [ "$TRAVIS" == "true" ]; then
	docker run $REPO /bin/sh -c "set -xeo pipefail; $str_TEST"
	docker run $REPO:dev /bin/sh -c "set -xeo pipefail; $str_TEST"
else
	eval "$str_TEST"
fi
