# Ansible playbook for SaltStack

## Setup

1. Download the Ansible roles:

```shell
ansible-galaxy install -r roles/requirements.yml
```

2. Download the terraform providers and modules:

```shell
cd terraform
terraform init
```

3. Set the DigitalOcean and CloudFlare credentials:

```shell
export TF_VAR_do_token="REPLACE_ME_WITH_THE_DO_TOKEN"
```

## Installation

Apply the playbook:
```
./playbook.yml
```

### Files

```
.
├── ansible.cfg - To tell Ansible how to work.
├── playbook.yml - The playbook to run.
├── group_vars - Variables used by Ansible.
├── roles - Where roles will be stored.
│   └── requirements.yml - What roles to download.
└── terraform - A description of the infrastrucure.
```
