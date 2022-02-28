#!/bin/bash
#
# Description: Prevents CA from removing nodes where its own pod is running
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./annotate_deployment_with_safe_evict.sh <app name>'
   echo 'i.e.   ./annotate_deployment_with_safe_evict.sh cluster-autoscaler'
   exit 0
fi

kubectl -n kube-system \
    annotate deployment.apps/$1 \
    $1.kubernetes.io/safe-to-evict="false"
