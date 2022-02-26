#!/bin/bash
#
# Description: checks if rbac is enabled
# Author: Rick Devaney
# Date: February 25, 2022
#

kubectl api-versions | grep rbac
