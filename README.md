# General Usage

The ansible playbook to prepare/install the requirements of Openshift v3 based from [Openshift Requirements](https://docs.openshift.org/latest/install_config/install/prerequisites.html)

## Export the Shell Variables

This script assumes that you already have provisioned Centos7 Virtual Machines:  

 - ec2-52-1-2-34-aws.com
 - ec2-10-1-2-33-aws.com

```bash
# The Ip addresses and hostnames of the hosts in the cluster
export Openshift_Master_Node_PUBLIC_HOSTNAME=ec2-52-1-2-34-aws.com
export Openshift_Master_Node_PUBLIC_IP=52.1.2.34
export Openshift_Minion_Node_PRIVATE_HOSTNAME=ec2-10-1-2-33-aws.com

# The device to be used by the docker-storage-setup command
export Openshift_Storage_Device_Name=/dev/xvdf
```

## Run the playbook

```bash
# Generate the openshift-hosts file
./generate_hosts.sh

# Run the playbook
ansible-playbook -i openshift-hosts -e "device_name=${Openshift_Storage_Device_Name}"
```
