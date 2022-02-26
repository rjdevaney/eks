#!/bin/bash
#
# Description: Deletes a cloudformation stack
# Author: Rick Devaney
# Date: February 25, 2022
#

if [[ $# -ne 1 ]]; then
    echo 'Usage: ./delete_cloudformation_stack.sh <stack name>'
    echo 'i.e.   ./delete_cloudformation_stack.sh eksworkshop-cf'
    exit 0
fi

if [[ -z "$1" ]]; then
    echo 'Usage: Please a stack name'
    exit 0
fi

aws cloudformation delete-stack --stack-name $1
