#!/bin/bash

# AWS-EKS客戶端，測試於Ubuntu 16.04，於Windows Bash也可使用

# install pip3 / aws-cli
sudo apt update ; sudo apt full-upgrade -y ; sudo apt autoremove -y
sudo apt install python3-pip -y
pip3 install --upgrade pip
pip3 install awscli

# install kubectl
mkdir ~/.kube
touch ~/.kube/config

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl
chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

# install helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# get heptio-authenticator-aws
cd /tmp
wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64
chmod +x /tmp/heptio-authenticator-aws_0.3.0_linux_amd64
sudo mv /tmp/heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/heptio-authenticator-aws

# 從aws下載worker-node的範本，要經過適當修改才能使用kubectl apply -f aws-auth-cm.yaml才能佈署worker-node
# curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/aws-auth-cm.yaml

# backup .bashrc
cp ~/.bashrc ~/.bashrc.backup
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'source <(helm completion bash)' >> ~/.bashrc
echo 'export KUBECONFIG=$KUBECONFIG:~/.kube/config' >> ~/.bashrc
echo 'complete -C '/home/ubuntu/.local/bin/aws_completer' aws' >> ~/.bashrc
source ~/.bashrc
