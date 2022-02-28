#!/bin/bash
#
# https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
# Description: Create an IAM OIDC identity provider for your cluster
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
    echo 'Usage: ./associate_iam_oidc_provider_for_cluster.sh <cluster name>'
    echo 'i.e.   ./associate_iam_oidc_provider_for_cluster.sh devaney-enterpises-us-east-2'
    echo 'Please a cluster name'
    exit 0
fi

eksctl utils associate-iam-oidc-provider --cluster $1 --approve
