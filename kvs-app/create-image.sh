#!/bin/bash

# build image from Dockerfile
docker build -t kvs .

# tag the image
docker tag kvs jaimefreire/kvs:1.0

# login on docker.hub
docker login

# push the image
docker push jaimefreire/kvs:1.0

# run the container from kvs image 
docker run --name kvs-app -it -p 5000:5000 jaimefreire/kvs:1.0
