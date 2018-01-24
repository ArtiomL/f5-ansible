# f5-ansible - Dockerfile
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.0, 24/01/2018

FROM alpine

LABEL maintainer="Artiom Lichtenstein" version="1.0.0"

# Core dependencies
RUN apk add --update --no-cache ansible py-pip && \
	rm -rf /var/cache/apk/*

# Ansible
COPY / /opt/ansible/
WORKDIR /opt/ansible/
RUN pip install bigsuds f5-sdk netaddr deepdiff

# System account
RUN adduser -u 1001 -D user

# UID to use when running the image and for CMD
USER 1001

# Run
CMD ["/bin/sh"]
