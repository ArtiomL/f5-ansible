#!/usr/bin/env python3
# f5-ansible - Run Playbooks
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.4, 15/09/2018

import argparse
import subprocess
import sys
import yaml

__author__ = 'Artiom Lichtenstein'
__license__ = 'MIT'
__version__ = '1.0.4'


def funArgParser():
	objArgParser = argparse.ArgumentParser(
		description = 'Run Ansible playbooks, executing the defined tasks on targeted hosts',
		epilog = 'https://github.com/ArtiomL/f5-ansible')
	objArgParser.add_argument('-c', '--iac', help ='infrastructure as code build', action = 'store_true')
	objArgParser.add_argument('-d', '--deploy', help ='deploy a playbook (default)', action = 'store_true')
	objArgParser.add_argument('-g', '--group', help ='inventory group for service nodes', dest = 'group')
	objArgParser.add_argument('-i', '--ip', help ='service (VS) IP address', dest = 'ip')
	objArgParser.add_argument('-n', '--name', help ='service template (iApp) name', dest = 'name')
	objArgParser.add_argument('-t', '--teardown', help ='teardown a playbook state', action = 'store_true')
	objArgParser.add_argument('-v', '--verbose', help='increase output verbosity', action='store_true')
	objArgParser.add_argument('PLAYBOOK', help = 'playbook name (default: iapp)', nargs = '?', default = 'iapp')
	return objArgParser.parse_args()


def main():
	objArgs = funArgParser()
	strParams = ''
	strPlay = 'playbooks/%s.yml' % objArgs.PLAYBOOK
	if objArgs.iac:
		intExit = 0
		diConfig = yaml.load(open('iac/config.yml', 'r'))
		for strName, diVars in diConfig['apps'].items():
			strParams = '-e service_name="%s" ' % strName
			if not diVars['state']:
				strParams += '-e state="absent" '
			else:
				strParams += '-e service_ip="%s" ' % diVars['ip']
				strParams += '-e service_group="%s" ' % diVars['group']
			strCmd = 'ansible-playbook %s -e @creds.yml --vault-password-file .password %s' % (strPlay, strParams)
			intExit += subprocess.call(strCmd, shell = True)
		sys.exit(intExit)

	if objArgs.teardown:
		strParams += '-e state="absent" '
	if objArgs.verbose:
		strParams += '-vvv '
	if objArgs.group:
		strParams += '-e service_group="%s" ' % objArgs.group
	if objArgs.ip:
		strParams += '-e service_ip="%s" ' % objArgs.ip
	if objArgs.name:
		strParams += '-e service_name="%s" ' % objArgs.name
	strCmd = 'ansible-playbook %s -e @creds.yml --ask-vault-pass %s' % (strPlay, strParams)
	sys.exit(subprocess.call(strCmd, shell = True))


def funBadExit(type, value, traceback):
	print('Unhandled Exception: %s, %s, %s' % (type, value, traceback))

sys.excepthook = funBadExit


if __name__ == '__main__':
	main()
