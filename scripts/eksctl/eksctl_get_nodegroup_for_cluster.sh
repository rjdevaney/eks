#!/bin/bash
#
# Description: eksctl get nodegroup for cluster
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./eksctl_get_nodegroup_for_cluster.sh <cluster name>'
   echo 'i.e.   ./eksctl_get_nodegroup_for_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

eksctl get nodegroup --cluster $1 -o json
