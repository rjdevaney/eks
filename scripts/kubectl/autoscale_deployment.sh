#!/bin/bash
#
# Description: Autoscales a deployment
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 4 ]]; then
   echo 'Usage: ./autoscale_deployment.sh <app name> <cpu %> <min pods> <max pods>'
   echo 'i.e.   ./autoscale_deployment.sh php-apache 50 1 10'
   exit 0
fi

kubectl autoscale deployment $1 `#The target average CPU utilization` \
   --cpu-percent=$2 \
   --min=$3 `#The lower limit for the number of pods that can be set by the autoscaler` \
   --max=$4 `#The upper limit for the number of pods that can be set by the autoscaler`
