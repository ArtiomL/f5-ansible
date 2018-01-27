# f5-ansible - Dockerfile
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.1, 27/01/2018

FROM alpine

LABEL maintainer="Artiom Lichtenstein" version="1.0.1"

# Core dependencies
RUN apk add --update --no-cache ansible py-pip && \
	pip install bigsuds f5-sdk netaddr deepdiff && \
	apk del py-pip && \
	rm -rf /var/cache/apk/*

# Ansible
COPY / /opt/ansible/
WORKDIR /opt/ansible/

# System account
RUN adduser -u 1001 -D user

# UID to use when running the image and for CMD
USER 1001

# Run
CMD ["/bin/sh"]
