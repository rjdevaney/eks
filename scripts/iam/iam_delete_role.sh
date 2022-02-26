#!/bin/bash
#
# Description: Deletes an iam role
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
    echo 'Usage: ./delete_iam_role.sh <role name>'
    echo 'i.e.   ./delete_iam_role.sh eks-service-role'
    exit 0
fi

if [[ -z "$1" ]]; then
    echo 'Usage: Please a role name'
    exit 0
fi

aws iam delete-role --role-name $1
