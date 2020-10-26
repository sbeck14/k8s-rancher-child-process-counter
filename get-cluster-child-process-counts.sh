#!/bin/bash

NODES=`rancher nodes | grep worker | awk '{print $2}'`

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
NODES_ARR=($NODES)
IFS=$SAVEIFS   # Restore IFS

printf '%-8s\t%-50s\t%s\n' "PID" "NAME" "COUNT"

for node in "${NODES_ARR[@]}"
do
  echo $node
  docker run --rm -it -v ~/.rancher/cli2.json:/root/.rancher/cli2.json k8s-rancher-child-process-counter $node
done
