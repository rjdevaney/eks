#!/bin/bash
#
# Description: Describes the cluster status
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./describe_cluster_status.sh <cluster name>'
   echo 'i.e.   ./describe_cluster_status.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

aws eks describe-cluster --name $1 --query "cluster.status"
