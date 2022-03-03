#!/bin/bash
#
# Description: Gets lifecyle of nodes
# Author: Rick Devaney
# Date: February 28, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_node_lifecyle.sh <lifecycle type>'
  echo 'i.e.   ./get_node_lifecycle.sh Ec2Spot'
  echo 'i.e.   ./get_node_lifecycle.sh OnDemand'
  exit 0
fi  

kubectl get nodes -l lifecycle=$1
