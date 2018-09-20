#!/bin/bash

set -eu -o pipefail

echo "Adding awslogs config..."
sudo mkdir -p /var/awslogs/state
sudo mkdir -p /etc/awslogs/
sudo cp /tmp/conf/awslogs/awslogs.conf /etc/awslogs/awslogs.conf

echo "Installing awslogs..."
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -o /tmp/awslogs-agent-setup.py
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/AgentDependencies.tar.gz -o /tmp/AgentDependencies.tar.gz
tar xf /tmp/AgentDependencies.tar.gz -C /tmp/
sudo python /tmp/awslogs-agent-setup.py --region us-west-2 --dependency-path /tmp/AgentDependencies --non-interactive --configfile=/etc/awslogs/awslogs.conf

echo "Configure awslogsd to run on startup..."
sudo systemctl enable awslogs.service
