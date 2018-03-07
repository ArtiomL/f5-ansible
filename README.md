# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible
[![Build Status](https://img.shields.io/travis/ArtiomL/f5-ansible/develop.svg)](https://travis-ci.org/ArtiomL/f5-ansible)
[![Releases](https://img.shields.io/github/release/ArtiomL/f5-ansible.svg)](https://github.com/ArtiomL/f5-ansible/releases)
[![Commits](https://img.shields.io/github/commits-since/ArtiomL/f5-ansible/latest.svg?label=commits%20since)](https://github.com/ArtiomL/f5-ansible/commits/master)
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
- [Extensibility](#extensibility)
- [Playbooks](#playbooks)
	- [Deploy](#deploy)
	- [Teardown](#teardown)
	- [Service Template](#service-template)
	- [Infrastructure as Code](#infrastructure-as-code)
- [Demos](#demos)
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

# Stable, runs as root (for Drone CI/CD)
docker run -it artioml/f5-ansible:su

# Experimental
docker run -it artioml/f5-ansible:dev
```

### Credentials
The encrypted [vault](https://docs.ansible.com/ansible/latest/vault.html) file ([creds.yml](creds.yml)) contains the BIG-IP credentials and the Slack incoming webhook token (used for notifications).

The vault password is: **_password_**

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

## Extensibility
The container will dynamically pull down (and `cd` to) whatever GitHub repository is specified in the `REPO` environment variable. This enables Continuous Delivery of new content every time the container is started and that repository is updated. It also allows you to load and run your own custom Ansible environments.

```shell
-e "REPO=<GitHub_Username>/<Repo_Name>"
```
For [example](https://github.com/jmcalalang/Ansible_Meetups):
```shell
docker run -it -e "REPO=jmcalalang/Ansible_Meetups" artioml/f5-ansible
```

&nbsp;&nbsp;

## Playbooks

### Deploy
```shell
./runsible.py {playbook_name}
```
For example:
```shell
./runsible.py app
# Which executes:
# ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass
```

### Teardown
```shell
./runsible.py -t {playbook_name}
```
For example:
```shell
./runsible.py -t app
# Which executes:
# ansible-playbook playbooks/app.yml -e @creds.yml --ask-vault-pass -e state="absent"
```

### Service Template
```shell
./runsible.py {playbook_name} -n [service_name] -i [service_ip] -g [service_group]
```
For example:
```shell
./runsible.py iapp -n iapp_Web1 -i 10.100.115.11
# Which executes:
# ansible-playbook playbooks/iapp.yml -e @creds.yml --ask-vault-pass -e service_name="iapp_Web1" -e service_ip="10.100.115.11"
```

### Infrastructure as Code
```shell
./runsible.py --iac
```
This helper script is using [`iac/config.yml`](iac/config.yml) as the L4-L7 configuration Single Source of Truth to deploy the infrastructur:
```yaml
---

apps:
  iapp_Web1:
    description: A web app protected by WAF
    ip: 10.100.115.11
    group: prod
    state: true
  iapp_Web2:
    description:
    ip: 10.100.115.12
    group:
    state: false
  iapp_Web3:
    description:
    ip: 10.100.115.13
    group:
    state: false

...
```

&nbsp;&nbsp;

## Demos

### Imperative Playbooks
https://www.youtube.com/watch?v=5QiNgWZeOw0

### Declarative Automation
https://www.youtube.com/watch?v=hy7GU2GfsWc


&nbsp;&nbsp;

## --help
```
./runsible.py --help
usage: runsible.py [-h] [-c] [-d] [-g GROUP] [-i IP] [-n NAME] [-t] [-v]
                   [PLAYBOOK]

Run Ansible playbooks, executing the defined tasks on targeted hosts

positional arguments:
  PLAYBOOK              playbook name (default: iapp)

optional arguments:
  -h, --help            show this help message and exit
  -c, --iac             infrastructure as code build
  -d, --deploy          deploy a playbook (default)
  -g GROUP, --group GROUP
                        inventory group for service nodes
  -i IP, --ip IP        service (VS) IP address
  -n NAME, --name NAME  service template (iApp) name
  -t, --teardown        teardown a playbook state
  -v, --verbose         increase output verbosity

https://github.com/ArtiomL/f5-ansible
```
