#!/bin/bash
#
# Description: Initializes external DNS
# Author: Rick Devaney
# Date: February 26, 2022
#

echo NOTE: this should create a service account, clusterrole, clusterrolebinding and a deployment
kubectl apply -f 01-initial-external-dns.yaml

echo Checking to see if external dns pod is running
get_pod.sh external-dns
