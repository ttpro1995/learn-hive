FROM apache/hive:4.0.0

USER root 
RUN apt-get update && apt-get install -y aria2
RUN aria2c -x 16 -s 16 -o postgresql-42.4.0.jar https://jdbc.postgresql.org/download/postgresql-42.4.0.jar
RUN cp postgresql-42.4.0.jar /opt/hive/lib
USER hive

