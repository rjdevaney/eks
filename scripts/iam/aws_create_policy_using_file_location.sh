#!/bin/bash
#
# Description: Creates aws iam policy using a file location
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 2 ]]; then
   echo 'Usage: ./aws_create_policy_using_file_location.sh <policy name> <policy location>'
   echo 'i.e.   ./aws_create_policy_using_file_location.sh k8s-asg-policy ~/environment/eks/cluster-autoscaler/k8s-asg-policy.json'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a policy name'
   exit 0
fi

if [[ -z "$2" ]]; then
   echo 'Usage: Please supply a policy file location'
   exit 0
fi

aws iam create-policy   \
  --policy-name $1 \
  --policy-document file://$2
