#!/bin/bash
#
# Description: setups up eksctl
# Author: Rick Devaney
# Date: February 26, 2022
#


curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar x
z -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin

# Confirm the eksctl command works:
eksctl version

# Enable eksctl bash-completion

eksctl completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
