#!/bin/bash
#
# Additionally all spot instances have a PreferNoSchedule taint. To deploy your pod on spot instances, use the node
# label selector to specify lifecycle=Ec2Spot, otherwise the pod will not be scheduled on the spot instance unless it
# has relevant tolerant. See kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration
#
# Description: Gets node taints
# Author: Rick Devaney
# Date: February 28, 2022
#

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./get_node_taint.sh <node name>'
  echo 'i.e.   ./get_node_taint.sh ip-100-64-106-134.ap-northeast-1.compute.internal'
  exit 0
fi  

kubectl get no/ip-100-64-106-134.ap-northeast-1.compute.internal -o json | jq .spec.taints

# Output is 
: '
[
  {
    "effect": "PreferNoSchedule",
    "key": "spotInstance",
    "value: "true"
  }
]
'
