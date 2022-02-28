#!/bin/bash
#
# Description: Configures for cluster autoscaling
# Author: Rick Devaney
# Date: February 27, 2022
#

if [[ $# -ne 2 ]]; then
   echo 'Usage: ./configure_ca_auto_scaler.sh <cluster name> <policy location>'
   echo 'i.e.   ./configure_ca_auto_scaler.sh devaney-enterprises-us-east-2 ~/cluster-autoscaler/k8s-asg-policy.json'
   exit 0
fi

# Source: https://www.eksworkshop.com/beginner/080_scaling/
# Cluster Autoscaler for AWS provides integration with Auto Scaling groups. It enables users to choose from four different options of deployment:

# * One Auto Scaling group
# * Multiple Auto Scaling groups
# * Auto-Discovery
# * Control-plane Node setup

# Auto-Discovery is the preferred method to configure Cluster Autoscaler. see https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws for more information.

# Cluster Autoscaler will attempt to determine the CPU, memory, and GPU resources provided by an Auto Scaling Group based on the instance type specified in its Launch Configuration or Launch Template.

## Configure the ASG

# You configure the size of your Auto Scaling group by setting the minimum, maximum, and desired capacity. When we created the cluster we set these settings to 3.

describe_auto_scaling_group.sh $1

# Now, increase the maximum capacity to 4 instances
export ASG_NAME=`get_auto_scaling_group_name.sh $1`

# Check new values
describe_auto_scaling_group.sh $1

## IAM roles for service accounts
# With IAM roles for service accounts on Amazon EKS clusters, you can associate an IAM role with a (https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/). This service account can then provide AWS permissions to the containers in any pod that uses that service account. With this feature, you no longer need to provide extended permissions to the node IAM role so that pods on that node can call AWS APIs.

# Enabling IAM roles for service accounts on your cluster
associate_iam_oidc_provider_for_cluster.sh $1

# Creating an IAM policy for your service account that will allow your CA pod to interact with the autoscaling groups.
mkdir ~/cluster-autoscaler

cat <<EoF > ~/cluster-autoscaler/k8s-asg-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EoF

aws_create_policy_using_file_location.sh $2

# Finally, create an IAM role for the cluster-autoscaler Service Account in the kube-system namespace.
create_iam_service_account.sh cluster-autoscaler kube-system $1 k8s-asg-policy

# Make sure your service account with the ARN of the IAM role is annotated
kubectl -n kube-system describe sa cluster-autoscaler

# Output is:
: '
Name:                cluster-autoscaler
Namespace:           kube-system
Labels:              <none>
Annotations:         eks.amazonaws.com/role-arn: arn:aws:iam::197520326489:role/eksctl-devaney-enterprises-us-east-2-addon-iamserviceac-Role1-12LNPCGBD6IPZ
Image pull secrets:  <none>
Mountable secrets:   cluster-autoscaler-token-vfk8n
Tokens:              cluster-autoscaler-token-vfk8n
Events:              <none>
'

# Deploy the Cluster Autoscaler (CA)
kubectl apply -f deploy_ca.files/cluster-autoscaler-autodiscover.yaml

# To prevent CA from removing nodes where its own pod is running, we will add the `cluster-autoscaler.kubernetes.io/safe-to-evict` annotation to its deployment with the following command
annotate_deployment_with_safe_evict.sh cluster-autoscaler

# Finally let's update the autoscaler image
export K8S_VERSION=`get_k8_short_version.sh`
export AUTOSCALER_VERSION=`get_auto_scaler_version.sh $K8S_VERSION`
set_image_deployment.sh cluster-autoscaler $AUTOSCALER_VERSION

# Watch the logs
kubectl -n kube-system logs -f deployment/cluster-autoscaler
