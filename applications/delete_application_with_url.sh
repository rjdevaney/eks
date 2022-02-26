#!/bin/bash
#
# Description: Deletes an application's resources when given a url
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./delete_application_with_url.sh <url>'
   echo 'i.e.   ./delete_application_with_url https://raw.githubusercontent.com/kubernetes/dashboard/src/deploy/recommended/kubernetes-dashboard.yaml'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a url'
   exit 0
fi

kubectl delete -f $1
