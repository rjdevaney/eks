#!/bin/bash
#
# Description: Configures for Horizontal Pod AutoScaler (HPA) autoscaling
# Author: Rick Devaney
# Date: February 27, 2022
#

# Source: https://www.eksworkshop.com/beginner/080_scaling/
# Deploy the Metrics Server

# Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines. These metrics will drive the scaling behavior of the https://kubernetes.io/docs/concepts/workloads/controllers/deployment/). We will deploy the metrics server using https://github.com/kubernetes-sigs/metrics-server).

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml

# Lets' verify the status of the metrics-server `APIService` (it could take a few minutes).piservice_status.sh
get_apiservice_status.sh v1beta1.metrics.k8s.io

# Output is:
: '
{
  "conditions": [
      {
        "lastTransitionTime": "2020-11-10T06:39:13Z",
        "message": "all checks passed",
        "reason": "Passed",
        "status": "True",
        "type": "Available"
      }
  ]
}
'
# We are now ready to scale a deployed application
