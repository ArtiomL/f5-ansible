#!/usr/bin/env python
# f5-ansible - Run Playbooks
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.0, 11/02/2018

import argparse
import subprocess
import sys

__author__ = 'Artiom Lichtenstein'
__license__ = 'MIT'
__version__ = '1.0.0'


def funArgParser():
	objArgParser = argparse.ArgumentParser(
		description = 'Run Ansible playbooks, executing the defined tasks on targeted hosts',
		epilog = 'https://github.com/ArtiomL/f5-ansible')
	objArgParser.add_argument('-d', '--deploy', help ='deploy a playbook (default)', action = 'store_true')
	objArgParser.add_argument('-t', '--teardown', help ='teardown a playbook state', action = 'store_true')
	objArgParser.add_argument('-v', '--verbose', help='increase output verbosity', action='store_true')
	objArgParser.add_argument('PLAYBOOK', help = 'playbook name', nargs = '?', default = 'app')
	return objArgParser.parse_args()


def main():
	objArgs = funArgParser()
	strState = strVerbose = ''
	strPlay = 'playbooks/%s.yml' % objArgs.PLAYBOOK
	if objArgs.teardown:
		strState = '-e state="absent"'
	if objArgs.verbose:
		strVerbose = '-vvv'
	strCmd = 'ansible-playbook %s -e @creds.yml --ask-vault-pass %s %s' % (strPlay, strState, strVerbose)
	subprocess.call(strCmd, shell = True)


def funBadExit(type, value, traceback):
	print('Unhandled Exception: %s, %s, %s' % (type, value, traceback))

sys.excepthook = funBadExit


if __name__ == '__main__':
	main()
