#!/bin/bash
#
# Description: Creates a cluster using a config file
# Author: Rick Devaney
# Date: February 26, 2022
#

if [[ $# -ne 1 ]]; then
   echo 'Usage: ./create_cluster.sh <file name>'
   echo 'i.e.   ./create_cluster.sh cluster_config_us_east_2.yaml'
   exit 0
fi

if [[ -z "$1" ]]; then
   echo 'Usage: Please supply a file name'
   exit 0
fi

eksctl create cluster -f $1
