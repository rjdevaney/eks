#!/bin/bash
#
# Description: Gets the aws az
# Author: Rick Devaney
# Date: February 26, 2022
#

aws ec2 describe-availability-zones --query 'AvailabilityZones[].ZoneName' --output text --region $AWS_REGION
