#!/usr/bin/env bash

# Path to script
DIRNAME=`dirname $0`
# Run config
source ${DIRNAME}/config.sh

# Default config
type=t1.micro
zone=us-east-1a
security_groups="-g default"

# Start instance
# note security group exp is "-g group1 -g group2 ..."
echo -e "\n*******************************************************************************\n" \
        "Launching ${BASE_UBUNTU_AMI} (${type}) in ${zone}" \
        "\n*******************************************************************************\n"
instance_id=$(ec2-run-instances ${BASE_UBUNTU_AMI} -t ${type} -k ${EC2_KEY_NAME} -z ${zone} ${security_groups}| awk '/INSTANCE/{print $2}')
if [[ ! "${instance_id}" =~ i-.+ ]]; then
  echo "Unable to run instance"
  exit 1
fi

# Waiting for instance
echo -e "\nWaiting for instance to be running" \
        "\n===============================================================================\n"
while ! ec2-describe-instances ${instance_id} | grep -q 'running'; do sleep 1; done
instance_address=$(ec2-describe-instances ${instance_id} | awk '/INSTANCE/{print $4}')
echo -e "\nInstance public address: ${instance_address}" \
        "\n===============================================================================\n"
echo -e "\nWaiting for instance to be ready" \
        "\n===============================================================================\n"
sleep 20

echo -e "\nInstanceID ${instance_id}" \
        "\n===============================================================================\n"

# Bootstrapping instance
eval scp ${SSH_OPTIONS} ${DIRNAME}/bootstrap.sh ${instance_address}:/tmp
eval ssh ${SSH_OPTIONS} ${instance_address} '/tmp/bootstrap.sh'

echo -e "\nProvisioning instance" \
        "\n===============================================================================\n"
${DIRNAME}/provision_ec2_instance.sh ${instance_address} ${DIRNAME}/../vagrant
echo -e "\n*******************************************************************************\n" \
        "Instance ready" \
        "\n*******************************************************************************\n"
        