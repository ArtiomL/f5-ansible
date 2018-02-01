# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible

#### `Run`
```shell
# Stable
docker run -it artioml/f5-ansible
# Experimental
docker run -it artioml/f5-ansible:dev
```

&nbsp;

#### `Credentials`
```shell
# View
ansible-vault view creds.yml
Vault password: password
bigip_user: "admin"
bigip_pass: "admin"
slack_token: "thetoken/generatedby/slack"
# Modify
ansible-vault edit creds.yml
Vault password: password
```

&nbsp;

#### `Deploy`
```shell
ansible-playbook playbooks/app.yml -e @creds.yml
Vault password: password
```

&nbsp;

#### `Destroy`
```shell
ansible-playbook playbooks/app.yml -e @creds.yml -e state="absent"
Vault password: password
```
