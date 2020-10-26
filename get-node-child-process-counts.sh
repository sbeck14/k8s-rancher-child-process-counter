#!/bin/bash

NODE=$1

if [ -z $NODE ]; then
  echo "Node argument required"
  exit 1
fi

docker run --rm -it -v ~/.rancher/cli2.json:/root/.rancher/cli2.json rancher-ssh-child-count $NODE