#!/bin/bash
#
# Description: Gets K8's auto scaler version
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_auto_scaling_version.sh <k8 short version>'
  echo 'i.e.   ./get_auto_scaling_version.sh 1.20'
  exit 0
fi

curl -s "https://api.github.com/repos/kubernetes/autoscaler/releases" | grep '"tag_name":' | sed -s 's/.*-\([0-9][0-9\.]*\).*/\1/' | grep -m1 $1
