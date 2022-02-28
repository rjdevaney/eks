#!/bin/bash
#
# Description: Gets an API service status
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./get_apiservice_status.sh <service name>'
   echo 'i.e.   ./get_apiservice_status.sh v1beta1.metrics.k8s.io'
   exit 0
fi

kubectl get apiservice $1 -o json | jq '.status'
