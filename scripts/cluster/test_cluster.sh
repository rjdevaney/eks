#!/bin/bash
#
# Description: Tests the cluster
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./test_cluster.sh <cluster name>'
   echo 'i.e.   ./test_cluster.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

# Test the cluster:
# Confirm your nodes:
echo kubectl should return 3 nodes
kubectl get nodes # if we see our 3 nodes, we know we have authenticated correctly

# Export the Worker Role Name for use throughout the workshop:

STACK_NAME=$(eksctl get nodegroup --cluster "$1" -o json | jq -r '.[].StackName')
ROLE_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::IAM::Role") | .PhysicalResourceId')
echo "export ROLE_NAME=${ROLE_NAME}" | tee -a ~/.bash_profile
