#!/bin/bash
#
# Description: Creates a Custom Managed Key (CMK)
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./create_custom_managed_key.sh <alias name>'
   echo 'i.e.   ./create_custom_managed_key.sh clusterkey'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply an alias name'
   exit 0
fi

aws kms create-alias --alias-name alias/$1 --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)

# Let's retrieve the ARN of the CMK to input into the create cluster command.

export MASTER_ARN=$(aws kms describe-key --key-id alias/$1 --query KeyMetadata.Arn --output text)

# We set the MASTER_ARN environment variable to make it easier to refer to the KMS key later.
#Now, let's save the MASTER_ARN environment variable into the bash_profile

echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
