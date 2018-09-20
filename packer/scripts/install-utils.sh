#!/bin/bash
set -eu -o pipefail

echo "Updating core packages"
sudo apt-get update
sudo apt-get -y upgrade

echo "Updating awscli..."
sudo apt-get update
sudo apt-get install -y python-pip
sudo pip install --upgrade pip
sudo pip install --upgrade awscli

echo "Installing zip utils..."
sudo apt-get install -y zip unzip

echo "Installing bats..."
sudo apt-get install -y git
sudo git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local

sudo "Installing CloudFormation helper scripts..."
curl https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz -o /tmp/aws-cfn-bootstrap-latest.tar.gz
tar xvf /tmp/aws-cfn-bootstrap-latest.tar.gz -C /tmp/
sudo easy_install /tmp/aws-cfn-bootstrap-1.4
ln -s /root/aws-cfn-bootstrap-latest/init/ubuntu/cfn-hup /etc/init.d/cfn-hup

echo "Installing bk elastic stack bin files..."
sudo chmod +x /tmp/conf/bin/bk-*
sudo mv /tmp/conf/bin/bk-* /usr/local/bin

echo "Configuring awscli to use v4 signatures..."
sudo aws configure set s3.signature_version s3v4
