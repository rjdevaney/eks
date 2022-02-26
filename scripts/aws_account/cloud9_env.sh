#!/bin/bash
#
# Description: Disables Cloud 9 temporary credentials
# Author: Rick Devaney
# Date: February 26, 2022
#

# Cloud9 normally manages IAM credentials dynamically. This isn't currently compatible with the EKS IAM authentication, 
# so we will disable it and rely on the IAM role instead.

# To ensure temporary credentials aren't already in place we will remove any existing credentials file as well as 
# disabling **AWS managed temporary credentials**:

aws cloud9 update-environment  --environment-id $C9_PID --managed-credentials-action DISABLE
rm -vf ${HOME}/.aws/credentials
