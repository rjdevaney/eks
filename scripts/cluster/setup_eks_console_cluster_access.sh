#!/bin/bash
#
# Description: Creates full acccess in the EKS console to the cluster
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./setup_eks_console_cluster_access.sh <cluster name>'
   echo 'i.e.   ./setup_eks_console_cluster_access.sh devaney-enterprises-us-east-2'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a cluster name'
   exit 0
fi

# This step is optional, as nearly all of the workshop content is CLI-driven. But, if you'd like full access to your workshop cluster in the EKS console this step is recommended.

# The EKS console allows you to see not only the configuration aspects of your cluster, but also to view Kubernetes cluster objects such as Deployments, Pods, and Nodes. For this type of access, the console IAM User or Role needs to be granted permission within the cluster.

# By default, the credentials used to create the cluster are automatically granted these permissions. Following along in the workshop, you've created a cluster using temporary IAM credentials from within Cloud9. This means that you'll need to add your AWS Console credentials to the cluster.

# Import your EKS Console credentials to your new cluster:

# IAM Users and Roles are bound to an EKS Kubernetes cluster via a ConfigMap named `aws-auth`. We can use `eksctl` to do this with one command.

# You'll need to determine the correct credential to add for your AWS Console access. If you know this already, you can skip ahead to the `eksctl create iamidentitymapping` step below.

# If you've built your cluster from Cloud9 as part of this tutorial, invoke the following within your environment to determine your IAM Role or User ARN. 

c9builder=$(aws cloud9 describe-environment-memberships --environment-id=$C9_PID | jq -r '.memberships[].userArn')
if echo ${c9builder} | grep -q user; then
	rolearn=${c9builder}
        echo Role ARN: ${rolearn}
elif echo ${c9builder} | grep -q assumed-role; then
        assumedrolename=$(echo ${c9builder} | awk -F/ '{print $(NF-1)}')
        rolearn=$(aws iam get-role --role-name ${assumedrolename} --query Role.Arn --output text) 
        echo Role ARN: ${rolearn}
fi

# With your ARN in hand, you can issue the command to create the identity mapping within the cluster.

eksctl create iamidentitymapping --cluster $1 --arn ${rolearn} --group system:masters --username admin

# Note that permissions can be restricted and granular but as this is a workshop cluster, you're adding your console credentials as administrator.

# Now you can verify your entry in the AWS auth map within the console.

kubectl describe configmap -n kube-system aws-auth

# Now you're all set to move on. For more information, check out the https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html on this topic.

: '
Output of this is:
Role ARN: arn:aws:iam::558904400609:user/rick
2022-02-26 11:00:33 [ℹ]  eksctl version 0.84.0
2022-02-26 11:00:33 [ℹ]  using region us-east-2
2022-02-26 11:00:33 [ℹ]  adding identity "arn:aws:iam::558904400609:user/rick" to auth ConfigMap
Name:         aws-auth
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Data
====
mapRoles:
----
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: arn:aws:iam::558904400609:role/eksctl-devaney-enterprises-us-eas-NodeInstanceRole-RHLIA95CC113
  username: system:node:{{EC2PrivateDNSName}}
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: arn:aws:iam::558904400609:role/eksctl-devaney-enterprises-us-eas-NodeInstanceRole-1FMFVAR85OEHV
  username: system:node:{{EC2PrivateDNSName}}

mapUsers:
----
- groups:
  - system:masters
  userarn: arn:aws:iam::558904400609:user/rick
  username: admin

Events:  <none>
'
