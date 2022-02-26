#!/bin/bash
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
