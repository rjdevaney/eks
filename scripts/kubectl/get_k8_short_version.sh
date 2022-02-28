#!/bin/bash
#
# Description: Gets K8's short version
# Author: Rick Devaney
# Date: February 27, 2022
#

kubectl version --short | grep 'Server Version:' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/' | cut -d. -f1,2
