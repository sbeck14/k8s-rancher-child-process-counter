# k8s-rancher-child-process-counter

If you want to know how many child processes each Kubernetes pod has on all of your nodes, look no further. At least if you're using rancher, anyway.

## Prerequisites

Kubernetes cluster managed by Rancher

Rancher CLI

Docker

## Instructions

Authenticate to your Rancher cluster using the Rancher CLI.

Build the docker image (you can use `./build.sh`)

> Optional: Edit the `get-cluster-child-process-counts.sh` script and change the `grep` filter to target the desired Rancher worker nodes

Run the `get-cluster-child-process-counts.sh` script to get counts across all worker nodes.

Run the `get-node-child-process-counts.sh NODE` script (replacing NODE with a rancher node name) to get counts for a specific node.

## TODO

Better output format? Probably not going to spend any more time on this
