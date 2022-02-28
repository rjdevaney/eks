#!/bin/bash
#
# Description: Tests scaling a Cluster with HPA
# Author: Rick Devaney
# Date: February 27, 2022
#

# Source: https://www.eksworkshop.com/beginner/080_scaling/
# Deploy a Sample App

# We will deploy an application and expose as a service on TCP port 80.

# The application is a custom-built image based on the php-apache image. The index.php page performs calculations to generate CPU load. More information can be found (https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/#run-expose-php-apache-server)

create_app_deployment.sh php-apache hpa-example
set_app_deployment_cpu_resource.sh php-apache
expose_app_port.sh php-apache 80
get_app_pod.sh php-apache

# Create an HPA resource
# This HPA scales up when CPU exceeds 50% of the allocated container resource.
autoscale_deployment.sh php-apache 50 1 10

# View the HPA using kubectl. You probably will see `<unknown>/50%` for 1-2 minutes and then you should be able to see `0%/50%`

get_hpa.sh

# Generate load to trigger scaling
# Open a new terminal in the Cloud9 Environment and run the following command to drop into a shell on a new container
load_generator.sh

# You will see HPA scale the pods from 1 up to our configured maximum (10) until the CPU average is below our target (50%). You can now stop (_Ctrl + C_) load test that was running in the other terminal. You will notice that HPA will slowly bring the replica count to min number based on its configuration. You should also get out of load testing application by pressing _Ctrl + D_.

