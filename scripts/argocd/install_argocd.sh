#!/bin/bash
#
# https://argo-cd.readthedocs.io/en/stable/getting_started/
# https://www.eksworkshop.com/intermediate/290_argocd/
# Description: Installs argocd
# Author: Rick Devaney
# Date: February 26, 2022
#

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Change the argocd-server service type to LoadBalancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Get the Argo server hostname
export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`
echo $ARGOCD_SERVER

# configure ingress for AWS
# https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/
kubectl create -f alb_argocd.yaml

# Once we create this service, we can configure the Ingress to conditionally route all application/grpc traffic to the new HTTP2 backend, using the alb.ingress.kubernetes.io/conditions annotation
kubectl create -f argocd_route_ingress.yaml

# Kubectl port-forwarding can also be used to connect to the API server without exposing the service
kubectl port-forward svc/argocd-server -n argocd 8080:443

#  Login Using The CLI
# The initial password for the admin account is auto-generated and stored as clear text in the field password in a secret named argocd-initial-admin-secret in your Argo CD installation namespace
echo setting ARGO_PWD
export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
echo $ARGO_PWD

# Using admin as login and the autogenerated password
argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

# Change the admin password
argocd account update-pasword

# create an application from a git repository
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

# Log into the ARGOCD UI
echo ARGOCD UI URL = https://$ARGOCD_SERVER
