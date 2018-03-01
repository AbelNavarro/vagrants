#!/bin/bash -x
echo "XXX install.sh - begin"

sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
#sudo su - stack
#git clone https://git.openstack.org/openstack-dev/devstack
#cd devstack

cd /opt/stack
sudo -u stack git clone https://git.openstack.org/openstack-dev/devstack
cd devstack

case $1 in
  "control" )
    echo "XXX control";
    sudo -u stack wget https://s3.eu-central-1.amazonaws.com/public-anavarro/devstack_control_-_local_conf.txt -O local.conf;;
  "compute01" )
    echo "XXX compute01";
    sudo -u stack wget https://s3.eu-central-1.amazonaws.com/public-anavarro/devstack_compute01_-_local_conf.txt -O local.conf;;
  "compute02" )
    echo "XXX compute02";
    sudo -u stack wget https://s3.eu-central-1.amazonaws.com/public-anavarro/devstack_compute02_-_local_conf.txt -O local.conf;;
  *) echo >&2 "Invalid option: $@"; exit 1;;
esac


sudo -u stack tr -d '\015' <local.conf | sudo -u stack tee local.conf
sudo -u stack ./stack.sh

echo "XXX install.sh - end"
