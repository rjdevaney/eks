#!/bin/bash
#
# Description: Deletes an application's resources when given a file path
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./delete_application.sh <file path>'
   echo 'i.e.   ./delete_application.sh ~/environment/ecs-demo'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a file path'
   exit 0
fi

cd $1
kubectl delete -f kubernetes/service.yaml
kubectl delete -f kubernetes/deployment.yaml
