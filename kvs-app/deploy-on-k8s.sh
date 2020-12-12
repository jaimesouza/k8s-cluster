#!/bin/bash

# create the deployment
kubectl create deployment kvs --image=jaimefreire/kvs:1.0

# check deployments state
kubectl get deployments

# check pods state
kubectl get pods

# expose the Kubernetes Deployment through a LoadBalancer
#kubectl expose deployment kvs --port 5000 --target-port=5000 --type LoadBalancer

# expose the Kubernetes Deployment through a NodePort service type
kubectl create service nodeport kvs --tcp=5000:5000

# find the external IP of the container
kubectl get services
