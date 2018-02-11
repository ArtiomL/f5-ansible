# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible
[![Build Status](https://img.shields.io/travis/ArtiomL/f5-ansible/develop.svg)](https://travis-ci.org/ArtiomL/f5-ansible)
[![Releases](https://img.shields.io/github/release/ArtiomL/f5-ansible.svg)](https://github.com/ArtiomL/f5-ansible/releases)
[![Commits](https://img.shields.io/github/commits-since/ArtiomL/f5-ansible/v1.0.0.svg?label=commits%20since)](https://github.com/ArtiomL/f5-ansible/commits/master)
[![Maintenance](https://img.shields.io/maintenance/yes/2018.svg)](https://github.com/ArtiomL/f5-ansible/graphs/code-frequency)
[![Issues](https://img.shields.io/github/issues/ArtiomL/f5-ansible.svg)](https://github.com/ArtiomL/f5-ansible/issues)
[![Docker Hub](https://img.shields.io/docker/pulls/artioml/f5-ansible.svg)](https://hub.docker.com/r/artioml/f5-ansible/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)
[![Slack Status](https://f5cloudsolutions.herokuapp.com/badge.svg)](https://f5cloudsolutions.herokuapp.com)

&nbsp;&nbsp;

## Table of Contents
- [Description](#description)
- [Installation](#installation)
	- [Run](#run)
	- [Credentials](#credentials)
- [Playbooks](#playbooks)
	- [Deploy](#deploy)
	- [Teardown](#teardown)
- [Help](#--help)
- [License](LICENSE)

&nbsp;&nbsp;

## Description

Essential Ansible container(s) with F5 modules, extensible playbooks and Slack notifications.

&nbsp;&nbsp;

## Installation

### Run
```shell
# Stable
docker run -it artioml/f5-ansible
# Experimental
docker run -it artioml/f5-ansible:dev
```

&nbsp;

### Credentials
The [encrypted](https://docs.ansible.com/ansible/latest/vault.html) [creds.yml](creds.yml) file contains the BIG-IP credentials and the Slack Webhook token (used for notifications).

The vault password is: **_password_**

> View:
```shell
ansible-vault view creds.yml
Vault password: password
bigip_user: "admin"
bigip_pass: "admin"
slack_token: "thetoken/generatedby/slack"
```

> Modify:
```shell
ansible-vault edit creds.yml
Vault password: password
```

&nbsp;&nbsp;

## Playbooks

### Deploy
```shell
./runsible.py {Playbook_Name}
```
For example:
```shell
./runsible.py app
# Which executes:
# ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass
```

&nbsp;

### Teardown
```shell
./runsible.py -t
# Which executes:
# ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass -e state="absent"
```

&nbsp;&nbsp;

## --help
```shell
./runsible.py --help
usage: runsible.py [-h] [-d] [-t] [-v] [PLAYBOOK]

Run Ansible playbooks, executing the defined tasks on targeted hosts

positional arguments:
  PLAYBOOK        playbook name (default: app)

optional arguments:
  -h, --help      show this help message and exit
  -d, --deploy    deploy a playbook (default)
  -t, --teardown  teardown a playbook state
  -v, --verbose   increase output verbosity

https://github.com/ArtiomL/f5-ansible
```
