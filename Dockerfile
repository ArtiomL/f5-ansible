# f5-ansible - Dockerfile
# https://github.com/ArtiomL/f5-ansible
# Artiom Lichtenstein
# v1.0.3, 04/02/2018

FROM alpine

LABEL maintainer="Artiom Lichtenstein" version="1.0.3"

# Core dependencies
RUN apk add --update --no-cache ansible git py-pip && \
	pip install bigsuds f5-sdk netaddr deepdiff && \
	apk del py-pip && \
	rm -rf /var/cache/apk/*

# Ansible
COPY / /opt/ansible/
WORKDIR /opt/ansible/

# System account and permissions
RUN adduser -u 1001 -D user
RUN chown -RL user: /opt/ansible/
RUN chmod +x scripts/start.sh

# UID to use when running the image and for CMD
USER 1001

# Run
CMD ["scripts/start.sh"]
