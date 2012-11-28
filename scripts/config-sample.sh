#!/usr/bin/env bash

# Global config
# This file runs global configs as well as local configs

# Determine where everything lives
DIRNAME=`dirname ${BASH_SOURCE}`

######################
# Required variables #
######################

# Java
export JAVA_HOME=<path to your Java home>

# EC2 tools (uncomment and fill out if not using an AWS AMI)
# export EC2_HOME=<path to ec2-api-tools home>
# export PATH=$PATH:$EC2_HOME/bin

#########################################################################
# These variables can be defined here or in an environemt specific file #
#########################################################################
export AWS_ACCESS_KEY=<your AWS_ACCESS_KEY>
export AWS_SECRET_KEY=<your AWS_SECRET_KEY>
export EC2_URL=ec2.us-east-1.amazonaws.com
# If you need to create a new pem file use:
# ec2-add-keypair --aws-access-key <your AWS_ACCESS_KEY> --aws-secret-key <your AWS_SECRET_KEY> --region us-east-1 ec2-us-east-1-keypair > ~/.ec2/ec2-us-east-1-keypair
# chmod 600 ~/.ec2/ec2-us-east-1-keypair
export EC2_KEY_PAIR=<path to your pem file>
export EC2_KEY_NAME=<your key name>
export BASE_UBUNTU_AMI=ami-9c78c0f5

############################################################
# Do not need to change unless you know what you are doing #
############################################################
# escape file name in case it has spaces
escaped_ec2_key_pair=$(echo $EC2_KEY_PAIR | sed 's/ /\\ /g')
export SSH_OPTIONS="-o User=ubuntu -i ${escaped_ec2_key_pair} -o Port=22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"