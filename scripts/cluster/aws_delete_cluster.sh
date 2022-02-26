#!/bin/bash
#
# Description: aws delete cluster 
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./aws_delete_cluster.sh <cluster name>'
   echo 'i.e.   ./aws_delete_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

aws eksctl delete cluster --name=$1
