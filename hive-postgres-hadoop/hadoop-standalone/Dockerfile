FROM eclipse-temurin:8-jdk-jammy

ENV HADOOP_VERSION=3.4.0
ENV JAVA_HOME=/opt/java/openjdk/

# RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
#     tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
#     mv hadoop-${HADOOP_VERSION} /usr/local/hadoop && \
#     rm hadoop-${HADOOP_VERSION}.tar.gz

RUN apt-get update
RUN apt-get -y install sudo axel ssh openssh-server

# RUN axel -n 8 https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
#     tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
#     mv hadoop-${HADOOP_VERSION} /opt/hadoop && \
#     rm hadoop-${HADOOP_VERSION}.tar.gz



COPY downloaded/hadoop-${HADOOP_VERSION}.tar.gz hadoop-${HADOOP_VERSION}.tar.gz 
RUN     tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

ENV HADOOP_HOME=/opt/hadoop
RUN mkdir /opt/hadoop/logs
RUN ln -s /opt/hadoop/etc/hadoop /etc/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop



ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"

# run hadoop standalone mode
# https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

# copy config
COPY etc/hadoop/hadoop-env.sh /etc/hadoop/hadoop-env.sh

# fix ssh to itself https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

 

# Script to start HDFS services
COPY entrypoint.sh ${HADOOP_HOME}/entrypoint.sh
COPY init.sh ${HADOOP_HOME}/init.sh
RUN chmod +x ${HADOOP_HOME}/entrypoint.sh

# CMD ["/usr/local/hadoop/start-hdfs.sh"]
# CMD ["tail" ,"-f" ,"/dev/null"]



ENTRYPOINT ["/opt/hadoop/entrypoint.sh"]