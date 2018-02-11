# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible
[![Build Status](https://img.shields.io/travis/ArtiomL/f5-ansible.svg)](https://travis-ci.org/ArtiomL/f5-ansible)
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
- [License](LICENSE)

&nbsp;&nbsp;

## Description

Essential Ansible container(s) with F5 modules and extensible playbooks.

&nbsp;&nbsp;

## Installation

#### Run
```shell
# Stable
docker run -it artioml/f5-ansible
# Experimental
docker run -it artioml/f5-ansible:dev
```

&nbsp;

#### Credentials
The encrypted [creds.yml](creds.yml) file contains the BIG-IP credentials and the Slack Webhook token.

The Vault password is: **_password_**

View:
```shell
ansible-vault view creds.yml
Vault password: password
bigip_user: "admin"
bigip_pass: "admin"
slack_token: "thetoken/generatedby/slack"
```
Modify:
```shell
ansible-vault edit creds.yml
Vault password: password
```

&nbsp;&nbsp;

## Playbooks

#### Deploy
```shell
./runsible.py
```
Or:
```shell
ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass
Vault password: password
```

&nbsp;

#### Teardown
```shell
./runsible.py -t
```
Or:
```shell
ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass -e state="absent"
Vault password: password
```
