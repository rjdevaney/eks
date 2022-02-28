#!/bin/bash
#
# Description: Create an app deployment
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 2 ]]; then
   echo 'Usage: ./create_app_deployment.sh <app name> <image name>'
   echo 'i.e.   ./create_app_deployment.sh php-apache hpa-example'
   exit 0
fi

kubectl create deployment $1 --image=us.gcr.io/k8s-artifacts-prod/$2
