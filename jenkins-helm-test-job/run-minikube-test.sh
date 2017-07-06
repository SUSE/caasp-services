#!/bin/bash

set -ex

export INSTANCE_NAME=$1
export CODE_PATH=$1
export WORKSPACE=$2

# Start build-specific minikube
minikube delete -p $INSTANCE_NAME|echo
minikube start --vm-driver kvm --profile $INSTANCE_NAME
echo minikube-created

# Deploy build-specific tiller
$WORKSPACE/helm-$INSTANCE_NAME init -i sushilkm/tiller:$INSTANCE_NAME
sleep 120 # Giving sometime for tiller to show up

# Test a chart
export TEST_RELEASE=`$WORKSPACE/helm-$INSTANCE_NAME install stable/mysql| grep "NAME:"|awk '{print $2}'`

# Delete the chart-release
$WORKSPACE/helm-$INSTANCE_NAME delete $TEST_RELEASE
