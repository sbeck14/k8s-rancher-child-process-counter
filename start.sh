#!/bin/sh

echo "LogLevel ERROR
Host *
  StrictHostKeyChecking no
  
  UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

rancher ssh $1 bash -s < get-pod-child-count.sh