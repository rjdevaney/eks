#!/bin/bash
#
# https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html
# Description: Determine whether you have an existing IAM OIDC provider for your cluster.
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./get_iam_oidc_for_cluster.sh <cluster name>'
   echo 'i.e.   ./get_iam_oidc_for_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

aws eks describe-cluster --name $1 --query "cluster.identity.oidc.issuer" --output text
