#!/bin/bash
#
# https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
# Enable service accounts to access AWS resources in three steps
# 1. Create an IAM OIDC provider for your cluster – You only need to do this once for a cluster.
# https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
# 2. Create an IAM role and attach an IAM policy to it with the permissions that your service accounts need – We recommend creating separate roles for each unique collection of permissions that pods need.
# https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html
# 3. Associate an IAM role with a service account – Complete this task for each Kubernetes service account that needs access to AWS resources.
# https://docs.aws.amazon.com/eks/latest/userguide/specify-service-account-role.html
#
# Description: Creates an iam service account
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 4 ]]; then
    echo 'Usage: ./create_iam_service_account.sh <account name> <namespace> <cluster name> <policy>' 
    echo 'i.e.   ./create_iam_service_account.sh cluster-autoscaler kube-system devaney-enterpises-us-east-2 k8s-asg-policy'
    exit 0
fi

if [[ -z "$1" ]]; then
    echo 'Usage: Please an account name'
    exit 0
fi

if [[ -z "$2" ]]; then
    echo 'Usage: Please a namespace' 
    exit 0
fi

if [[ -z "$3" ]]; then
    echo 'Usage: Please a cluster name'
    exit 0
fi

if [[ -z "$4" ]]; then
    echo 'Usage: Please a policy name'
    exit 0
fi

eksctl create iamserviceaccount \
    --name $1 \
    --namespace $2 \
    --cluster $3 \
    --attach-policy-arn "arn:aws:iam::${ACCOUNT_ID}:policy/$4" \
    --approve \
    --override-existing-serviceaccounts
