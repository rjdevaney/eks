#!/bin/bash
#
# Description: Sets an app's deployment cpu resource
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./set_app_deployment_cpu_resource.sh <app name>'
   echo 'i.e.   ./set_app_deployment_cpu_resource.sh php-apache'
   exit 0
fi

kubectl set resources deploy $1 --requests=cpu=200m
