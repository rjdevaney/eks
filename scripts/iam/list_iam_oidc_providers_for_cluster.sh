#!/bin/bash
#
# https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html
# Description: List the IAM OIDC providers in your account
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./list_iam_oidc_providers_for_cluster.sh <cluster_name>'
   echo 'i.e.   ./list_iam_oidc_providers_for_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

OIDC_PROVIDER_URL=`get_iam_oidc_for_cluster.sh "$1"`
URL=`echo $OIDC_PROVIDER_URL | sed 's/https:\/\/oidc.eks.us-east-2.amazonaws.com\/id\///'`

OIDC_PROVIDER=`aws iam list-open-id-connect-providers | grep "$URL"`
echo $OIDC_PROVIDER
