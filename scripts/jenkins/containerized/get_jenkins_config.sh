#!/bin/bash
#
# Description: Gets Jenkins config info
# Author: Rick Devaney
# Date: February 26, 2022
#

export SERVICE_IP=$(kubectl get svc --namespace default my-release-jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo "Jenkins URL: http://$SERVICE_IP/"

echo "Jenkins Username: user"
JENKINS_PWD=$(kubectl get secret --namespace default my-release-jenkins -o jsonpath="{.data.jenkins-password}" | base64 --decode)
echo "Jenkins Password: $JENKINS_PWD"

