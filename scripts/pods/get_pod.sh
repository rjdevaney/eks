#!/bin/bash
#
# Description: Shortcut to get a specific pod
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_pod.sh <pod name>'
  echo 'i.e.   ./get_pod.sh nginx-bdc5c7d65-82ldg'
  exit 0
fi  

if [[ -z "$1" ]]; then
  echo 'Usage: Please supply a pod name'
  exit 0
fi  

kubectl get pods | grep $1
