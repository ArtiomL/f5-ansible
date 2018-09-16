#!/bin/sh
# f5-ansible - Interactive Tests
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.1, 16/09/2018

git clone https://github.com/ArtiomL/f5-ansible.git
cd f5-ansible

# Linting
for file in */*.yml; do echo "$file"; python3 -c 'import yaml,sys; yaml.safe_load(sys.stdin)' < "$file"; done

# Credentials
ansible-vault edit creds.yml --vault-password-file .password

set -x

# Imperative Playbooks
./runsible.py cmd
./runsible.py app
./runsible.py app
set +x; read -p "Please break the SSoT for vs_Web"; set -x
./runsible.py app
./runsible.py -t app
./runsible.py app -n test_App1 -i 10.100.115.115
./runsible.py app -n test_App1 -t

# Declarative Automation
./runsible.py iapp -n test_iApp1 -i 10.100.115.115
./runsible.py iapp -n test_iApp2 -i 10.100.115.116
set +x; read -p "Please break the SSoT for test_iApp2"; set -x
./runsible.py iapp -n test_iApp2 -i 10.100.115.116
./runsible.py iapp -n test_iApp1 -t
./runsible.py iapp -n test_iApp2 -t
./runsible.py iapp -n iapp_Web1 -i 10.100.115.11 -g prod

# Infrastructure as Code
./runsible.py --iac
vi iac/config.yml
./runsible.py --iac
vi iac/config.yml
./runsible.py --iac
