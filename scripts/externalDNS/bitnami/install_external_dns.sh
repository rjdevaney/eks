#!/bin/bash
#
# https://github.com/bitnami/charts/tree/master/bitnami/external-dns
# Description: Initializes external DNS using bitnami
# Author: Rick Devaney
# Date: February 26, 2022
#

# Using IRSA
# If you are deploying to AWS EKS and you want to leverage IRSA. You will need to override fsGroup and runAsUser with 65534(nfsnobody) and 0 respectively. Otherwise service account token will not be properly mounted. You can use the following arguments:
# --set podSecurityContext.fsGroup=65534 --set podSecurityContext.runAsUser=0

helm install my-release -f values.yaml bitnami/external-dns --set podSecurityContext.fsGroup=65534 --set podSecurityContext.runAsUser=0

echo Checking to see if external dns pod is running
get_pod.sh external-dns
