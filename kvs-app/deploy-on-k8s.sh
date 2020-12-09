#!/bin/bash

# create the deployment
kubectl create deployment kvs --image=jaimefreire/kvs:1.0

# check deployments state
kubectl get deployments

# check pods state
kubectl get pods

# expose the Kubernetes Deployment through a Load Balancer
kubectl expose deployment kvs --port 5000 --target-port=5000 --type LoadBalancer

# find the external IP of the container
kubectl get services
