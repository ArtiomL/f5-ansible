#!/bin/sh
# f5-ansible - Docker Wrapper Script
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.1, 04/02/2018

if [[ ! -z "$REPO" ]]; then
	git clone "https://github.com/$REPO.git"
	cd $(echo "$REPO" | cut -d"/" -f2)
fi

exec /bin/sh
