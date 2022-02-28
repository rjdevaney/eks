#!/bin/bash
#
# Description: Shortcut to get a specific pod for an app
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_app_pod.sh <pod name>'
  echo 'i.e.   ./get_app_pod.sh nginx-bdc5c7d65-82ldg'
  exit 0
fi  

kubectl get pods -l app=$1
