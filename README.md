# <img align="center" src="img/ansible.svg" width="70">&nbsp;&nbsp; f5-ansible


```
docker run -it artioml/f5-ansible
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
ansible-playbook playbooks/unapp.yml -e @creds.yml
Vault password: password
```
