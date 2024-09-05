#!/bin/bash

# script here run once when created container
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    bash ${HADOOP_HOME}/init.sh
    echo "-----------------Done start up -------------------"
else
    echo "-- Not first container startup --"
fi


# 

eval $(ssh-agent)

ssh-add ~/.ssh/id_rsa

sudo service ssh restart

# Start the HDFS namenode and datanode
# $HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-dfs.sh

# browser default  http://localhost:9870/

# Keep the container running
tail -f /dev/null
