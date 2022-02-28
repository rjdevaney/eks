#!/bin/bash
#
# Description: Exposes an app's port
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 2 ]]; then
   echo 'Usage: ./expose_app_port.sh <app name> <port number>'
   echo 'i.e.   ./expose_app_port.sh php-apache 80'
   exit 0
fi

kubectl expose deploy $1 --port $2
