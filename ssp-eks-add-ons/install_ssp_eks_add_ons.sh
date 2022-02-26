#!/bin/bash
#
# Description: Installs argocd
# Author: Rick Devaney
# Date: February 25, 2022
#

kubectl apply -n argocd -f application.yaml 
