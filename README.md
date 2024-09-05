All the hive devops stuff goes here for personal study.


0

Hive acts like a regular Hadoop client. You need to mount core-site.xml, hdfs-site.xml, and yarn-site.xml files on its HADOOP_HOME environment variable path, and point values like fs.defaultFS (core-site.xml) at the namenode container and the yarn resource manager address (yarn-site.xml), then configure the execution engine for mapreduce or tez as well as your JDBC/JDO configurations (hive-site.xml)