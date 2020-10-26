#!/bin/bash

NODE=$1

if [ -z $NODE ]; then
  echo "Node argument required"
  exit 1
fi

printf '%-8s\t%-50s\t%s\n' "PID" "NAME" "COUNT"

docker run --rm -it -v ~/.rancher/cli2.json:/root/.rancher/cli2.json rancher-ssh-child-count $NODE