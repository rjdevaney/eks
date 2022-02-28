#!/bin/bash
#
# Description: Gets autoscaling group name
# Author: Rick Devaney
# Date: February 2r75, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_auto_scaling_group_name.sh <cluster name>'
  echo 'i.e.   ./get_auto_scaling_group_name.sh devaney-enterprises-us-east-2'
  echo 'Please supply a cluster name'
  exit 0
fi

aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[? Tags[? (Key=='eks:cluster-name') && Value=='"$1"']].AutoScalingGroupName" --output text
