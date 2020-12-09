# Pull base image
FROM mongo:latest

RUN apt update && apt upgrade -y && apt install python3 python3-dev python3-pip git -y

RUN pip3 install flask pymongo

# Define working directory.
WORKDIR /data

RUN git clone https://github.com/jaimesouza/k8s-cluster.git

RUN mv k8s-cluster/kvs-app /data/kvs-app/

RUN rm -rf k8s-cluster

RUN echo "mongod &" >> /data/startup.sh

RUN echo "python3 /data/kvs-app/app.py" >> /data/startup.sh

# Define default command
CMD bash /data/startup.sh

# Expose ports
EXPOSE 5000
