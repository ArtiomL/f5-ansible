#!/bin/sh
# f5-ansible - Docker Wrapper Script
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.0, 04/02/2018

if [[ ! -z "$REPO" ]]; then
	git clone "https://github.com/$REPO.git"
fi

exec /bin/sh
