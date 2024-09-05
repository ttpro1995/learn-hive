#!/bin/bash


# Set some sensible defaults
# export CORE_CONF_fs_defaultFS=${CORE_CONF_fs_defaultFS:-hdfs://`hostname -f`:8020}
export CORE_CONF_fs_defaultFS=${CORE_CONF_fs_defaultFS:-hdfs://localhost:9000}
export HDFS_CONF_dfs_replication=1


function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}

function configure() {
    local path=$1
    local module=$2
    local envPrefix=$3

    local var
    local value
    
    echo "Configuring $module"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do 
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/@/g; s/_/./g; s/@/_/g;'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addProperty $path $name "$value"
    done
}

configure /etc/hadoop/core-site.xml core CORE_CONF
configure /etc/hadoop/hdfs-site.xml hdfs HDFS_CONF
# configure /etc/hadoop/yarn-site.xml yarn YARN_CONF
# configure /etc/hadoop/httpfs-site.xml httpfs HTTPFS_CONF
# configure /etc/hadoop/kms-site.xml kms KMS_CONF
# configure /etc/hadoop/mapred-site.xml mapred MAPRED_CONF


addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.rpc-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.servicerpc-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.http-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.https-bind-host 0.0.0.0
# addProperty /etc/hadoop/hdfs-site.xml dfs.client.use.datanode.hostname true
# addProperty /etc/hadoop/hdfs-site.xml dfs.datanode.use.datanode.hostname true



eval $(ssh-agent)

ssh-add ~/.ssh/id_rsa

sudo service ssh restart

# Start the HDFS namenode and datanode
$HADOOP_HOME/bin/hdfs namenode -format
# $HADOOP_HOME/sbin/start-dfs.sh