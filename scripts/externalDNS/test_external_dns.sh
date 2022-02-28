#!/bin/bash
#
# Description: Tests external DNS
# Author: Rick Devaney
# Date: February 26, 2022
#

echo Note: This should create the nginx service and deployment
kubectl apply -f 02-testing-external-dns.yaml

echo Checking to see if nginx pod is running
get_pod.sh nginx

echo This will create an EC2 load balancer
