#!/bin/bash
#
# Description: Describes service accounts based on namespace
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./describe_service_accounts.sh <namespace>'
   echo 'i.e.   ./describe_service_accounts.sh default'
   echo 'i.e.   ./describe_service_accounts.sh kube-system'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a namespace'
   exit 0
fi

kubectl -n $1 describe sa
