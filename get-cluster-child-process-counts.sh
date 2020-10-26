#!/bin/bash

NODES=`rancher nodes | grep worker | awk '{print $2}'`

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
NODES_ARR=($NODES)
IFS=$SAVEIFS   # Restore IFS

for node in "${NODES_ARR[@]}"
do
  echo $node
  docker run --rm -it -v ~/.rancher/cli2.json:/root/.rancher/cli2.json rancher-ssh-child-count $node
done
