#!/usr/bin/env bash

# Path to script
DIRNAME=`dirname $0`
# Run config
source ${DIRNAME}/config.sh

export EC2_SSH_PRIVATE_KEY=${EC2_KEY_PAIR}
${DIRNAME}/../ec2/vagrant-ec2/setup.sh $1 ${DIRNAME}/../vagrant