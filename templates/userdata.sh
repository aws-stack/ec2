#!/bin/bash
#TODO: make the script OS-aware (debian/ubuntu/arch/etc)
yum -y install python-crypto python-paramiko python-yaml python-jinja2 python-simplejson python-pip git
pip install --upgrade pip
pip install ansible

echo > /etc/ec2_conf.yml <<EOF
{{ ec2_conf | to_yaml }}
EOF

ssh-keyscan {{ deploy_host }} >> ~/.ssh/known_hosts
{% if deploy_key is defined %}
echo "{{ deploy_key }}" >> ~/.ssh/deploy_key
{% endif %}
repo_url="{% if deploy_username is defined %}{{ deploy_username }}@{%- endif %}{{ deploy_host }}:{{ deploy_repo }}"

ansible-pull -i localhost, -c local --accept-host-key \
    -C {{ deploy_branch | default('master') }} \
    -U "$repo_url" deploy/deploy.yml \
    -e target=localhost -e @/etc/ec2_conf.yml

