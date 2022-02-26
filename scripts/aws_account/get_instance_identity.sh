#!/bin/bash
#
# Description: Gets the instance identity
# Author: Rick Devaney
# Date: February 26, 2022
#

curl -s 169.254.169.254/latest/dynamic/instance-identity/document
