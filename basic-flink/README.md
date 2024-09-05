/opt/flink/bin/flink run -py /opt/meow/code/word_count.py


```
# Remember to download whole flink so we get the *.jar
# 
javac -cp "/home/tt-pc/software/flink-1.20.0-bin-scala_2.12/flink-1.20.0/lib/*" WordCount.java
echo "Main-Class: WordCount" > manifest.txt
jar cvfm wordcount.jar manifest.txt WordCount*.class


```
/opt/flink/bin/flink run /opt/meow/code/wordcount.jar