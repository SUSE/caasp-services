#!/bin/bash
set -x

# Image already has docker, git, mercurial and golang installed

# Setup environment variables
export GOPATH=~/work
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/go/bin:~/work/src/k8s.io/helm/bin

# Check go version
go version

# Start docker service
service docker start

# Get helm code from jenkins server
mkdir -p ~/work/src/k8s.io
cd ~/work/src/k8s.io
mv ~/$1 ~/work/src/k8s.io/helm
cd helm

# Run helm-unit-tests
make test

# Make helm binary to be used for other tests
make build
mv bin/helm ~/helm

# Copy docker config
mkdir ~/.docker
mv ~/docker-config.json ~/.docker/config.json

# Generate docker image for the pull-request
make docker-build

# Tag and upload PR's build-specific docker image
docker tag gcr.io/kubernetes-helm/tiller:canary sushilkm/tiller:$2
docker push sushilkm/tiller:$2
