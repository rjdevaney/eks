#!/bin/bash
#
# Description: Gets the aws account
# Author: Rick Devaney
# Date: February 26, 2022
#

aws sts get-caller-identity --output text --query Account
