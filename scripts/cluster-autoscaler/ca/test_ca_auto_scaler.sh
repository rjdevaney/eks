#!/bin/bash
#
# Description: Tests scaling a Cluster with CA
# Author: Rick Devaney
# Date: February 27, 2022
#

# Source: https://www.eksworkshop.com/beginner/080_scaling/
# Deploy a Sample App
# We will deploy an sample nginx application as a `ReplicaSet` of 1 `Pod`
cat <<EoF> ~/cluster-autoscaler/nginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-to-scaleout
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        service: nginx
        app: nginx
    spec:
     containers:
     - image: nginx
       name: nginx-to-scaleout
       resources:
         limits:
           cpu: 500m
           memory: 512Mi
       requests:
           cpu: 500m
           memory: 512Mi
EoF

kubectl apply -f ~/environment/cluster-autoscaler/nginx.yaml
kubectl get deployment/nginx-to-scaleout

# Scale our ReplicaSet
# Let's scale out the replicaset to 10
kubectl scale --replicas=10 deployment/nginx-to-scaleout

# Some pods will be in the `Pending` state, which triggers the cluster-autoscaler to scale out the EC2 fleet.
kubectl get pods -l app=nginx -o wide --watch

# Output is:
: '
nginx-to-scaleout-7cb554c7d5-2d4gp   0/1       Pending   0          11s
nginx-to-scaleout-7cb554c7d5-2nh69   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-45mqz   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-4qvzl   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-5jddd   1/1       Running   0          34s
nginx-to-scaleout-7cb554c7d5-5sx4h   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-5xbjp   0/1       Pending   0          11s
nginx-to-scaleout-7cb554c7d5-6l84p   0/1       Pending   0          11s
nginx-to-scaleout-7cb554c7d5-7vp7l   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-86pr6   0/1       Pending   0          12s
nginx-to-scaleout-7cb554c7d5-88ttw   0/1       Pending   0          12s
'

# View the cluster-autoscaler logs
kubectl -n kube-system logs -f deployment/cluster-autoscaler

# Check the EC2 AWS Management Console(https://console.aws.amazon.com/ec2/home?#Instances:sort=instanceId) to confirm that the Auto Scaling groups are scaling up to meet demand. This may take a few minutes. You can also follow along with the pod deployment from the command line. You should see the pods transition from pending to running as nodes are scaled up or by using the kubectl

kubectl get nodes
# Output is:
: '
ip-192-168-12-114.us-east-2.compute.internal   Ready    <none>   3d6h   v1.17.7-eks-bffbac
ip-192-168-29-155.us-east-2.compute.internal   Ready    <none>   63s    v1.17.7-eks-bffbac
ip-192-168-55-187.us-east-2.compute.internal   Ready    <none>   3d6h   v1.17.7-eks-bffbac
ip-192-168-82-113.us-east-2.compute.internal   Ready    <none>   8h     v1.17.7-eks-bffbac
'
