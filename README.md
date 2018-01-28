# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible

#### `Run`
```shell
# Stable
docker run -it artioml/f5-ansible
# Experimental
docker run -it artioml/f5-ansible:dev
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
