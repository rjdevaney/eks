#!/bin/bash
#
# Description: Deletes a cluster 
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./delete_cluster.sh <cluster name>'
   echo 'i.e.   ./delete_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

eksctl delete cluster --name=$1
