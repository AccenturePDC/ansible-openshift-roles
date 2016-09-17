#!/bin/bash -e

cat > openshift-hosts <<EOF
# Create an OSEv3 group that contains the masters and nodes groups
[OSEv3:children]
masters
nodes

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
# SSH user, this user should allow ssh based auth without requiring a password
ansible_ssh_user=centos

# If ansible_ssh_user is not root, ansible_sudo must be set to true
ansible_sudo=true

deployment_type=origin

# uncomment the following to enable htpasswd authentication; defaults to DenyAllPasswordIdentityProvider
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]

# Use something like apps.<public-ip>.xip.io if you don't have a custom domain
openshift_master_default_subdomain=apps.${Openshift_Master_Node_PUBLIC_IP}.xip.io

[masters]
${Openshift_Master_Node_PUBLIC_HOSTNAME}

[nodes]
# Make the master node schedulable by default
${Openshift_Master_Node_PUBLIC_HOSTNAME} openshift_node_labels="{'region': 'infra', 'zone': 'default'}" openshift_schedulable=true

# You can add some nodes below if you want!
${Openshift_Minion_Node_PRIVATE_HOSTNAME} openshift_node_labels="{'region': 'primary', 'zone': 'default'}"
EOF

