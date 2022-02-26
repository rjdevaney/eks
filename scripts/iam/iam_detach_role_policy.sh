#!/bin/bash
#
# Description: Deletes an iam role policy
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 2 ]]; then
    echo 'Usage: ./delete_iam_role_policy.sh <role name> <policy>'
    echo 'i.e.   ./delete_iam_role_policy.sh eks-service-role AmazonEKSServicePolicy'
    exit 0
fi

if [[ -z "$1" ]]; then
    echo 'Usage: Please a role name'
    exit 0
fi

if [[ -z "$2" ]]; then
    echo 'Usage: Please a policy name'
    exit 0
fi

aws iam detach-role-policy --role-name $1 --policy-arn "arn:aws:iam::aws:policy/$2"
