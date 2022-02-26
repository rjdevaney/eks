#!/bin/bash
#
# Description: Configures the Cloud 9 workspace
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./cloud9_workspace.sh <role>'
  echo 'i.e.   ./cloud9_workspace.sh devaney-enterprises-admin'
  exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a role name'
   exit 0
fi

./cloud9_env.sh

# We should configure our aws cli with our current region as default.

export ACCOUNT_ID=`./get_aws_account.sh`
export AWS_REGION=`./get_aws_region.sh`
export AZS=($(aws ec2 describe-availability-zones --query 'AvailabilityZones[].ZoneName' --output text --region $AWS_REGION))

# Check if AWS_REGION is set to desired region
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

# Let's save these into bash_profile

echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
echo "export AZS=(${AZS[@]})" | tee -a ~/.bash_profile

aws configure set default.region ${AWS_REGION}
aws configure get default.region

# Validate the IAM role
# Use the https://docs.aws.amazon.com/cli/latest/reference/sts/get-caller-identity.html CLI command to validate that the Cloud9 IDE is using the correct IAM role.

aws sts get-caller-identity --query Arn | grep $1 -q && echo "IAM role valid" || echo "IAM role NOT valid"
