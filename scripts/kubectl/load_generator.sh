#!/bin/bash
#
# Description: Generates a load using busybox image
# Author: Rick Devaney
# Date: February 27, 2022
#

kubectl --generator=run-pod/v1 run -i --tty load-generator --image=busybox /bin/sh
