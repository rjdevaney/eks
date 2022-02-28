#!/bin/bash
#
# Description: Describes autoscaling groups
# Author: Rick Devaney
# Date: February 25, 2022
#
if [[ $# -ne 1 ]]; then
  echo 'Usage: ./describe_auto_scaling_group.sh <cluster name>'
  echo 'i.e.   ./describe_auto_scaling_group.sh devaney-enterprises-us-east-2'
  exit 0
fi

if [[ -z "$1" ]]; then
  echo 'Usage: Please supply a cluster name'
  exit 0
fi

aws autoscaling \
     describe-auto-scaling-groups \
     --query "AutoScalingGroups[? Tags[? (Key=='eks:cluster-name') && Value=='"$1"']].[AutoScalingGroupName, MinSize, MaxSize,DesiredCapacity]" \
     --output table
