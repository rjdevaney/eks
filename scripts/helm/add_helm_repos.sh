#!/bin/bash
#
# Description: Adds known helm repos
# Author: Rick Devaney
# Date: February 25, 2022
#

helm repo add eks https://aws.github.io/eks-charts
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add karpenter https://charts.karpenter.sh
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm repo add secrets-store-csi-driver \
	  https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/charts
