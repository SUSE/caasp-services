#!/bin/bash

source /root/openstack_credentials.rc
export VM_IMAGE=$1
export OS_PASSWORD=$2
export INSTANCE_NAME=$3
export CODE_PATH=$3
export WORKSPACE=$4

set -ex

# Boot a nova VM
nova boot --image $VM_IMAGE --flavor 402e9686-acbe-4622-a411-1a9f7845cbcd --key-name jenkins-key --nic net-name=shared-net $INSTANCE_NAME
echo nova-vm-created

# Assign a floating IP to nova vm and sleep for sometime until VM gets active and SSH-able
export FLOATING_IP=`openstack floating ip create ext-net| grep floating_ip_address| awk -F '| ' '{print $4}'`
sleep 60
nova floating-ip-associate $INSTANCE_NAME $FLOATING_IP
sleep 120

# Copy the code to VM
rsync -avz -e ssh ${WORKSPACE}/ $FLOATING_IP:~/$CODE_PATH > /dev/null

# Copy the dependency packages to VM
rsync -avz -e ssh ~/helm-unit-tests/vendor $FLOATING_IP:~/$CODE_PATH/ > /dev/null
rsync -avz -e ssh ~/helm-unit-tests/bin $FLOATING_IP:~/$CODE_PATH/ > /dev/null

# Copy test script to VM
scp ./run-test.sh $FLOATING_IP:~/

# Copy docker config to VM
scp ~/.docker/config.json $FLOATING_IP:~/docker-config.json

# Run test script on VM
echo Running Tests!!!
ssh $FLOATING_IP "~/run-test.sh ${CODE_PATH} ${INSTANCE_NAME}"

# Extract custom built helm back to jenkins server
scp $FLOATING_IP:~/helm $WORKSPACE/helm-$INSTANCE_NAME


# Start the docker service and default kvm network 
service docker start|echo
virsh net-start default| echo

# Deploy and run helm command on a custom minikube installation
su -s /bin/bash -l jenkins  -c "$PWD/run-minikube-test.sh $INSTANCE_NAME $WORKSPACE"
