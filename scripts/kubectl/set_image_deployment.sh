#!/bin/bash
#
# Description: Sets/updates image deployment
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 2 ]]; then
   echo 'Usage: ./set_image_deployment.sh <app name> <app version>'
   echo 'i.e.   ./set_image_deployment.sh cluster-autoscaler 1.2'
   exit 0
fi

kubectl -n kube-system \
    set image deployment.apps/$1 \
    $1=us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v$2
