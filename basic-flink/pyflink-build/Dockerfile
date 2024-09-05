FROM flink:1.20.0-scala_2.12-java8

# install python3: it has updated Python to 3.9 in Debian 11 and so install Python 3.7 from source
# it currently only supports Python 3.6, 3.7 and 3.8 in PyFlink officially.

RUN apt-get update -y && \
apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libffi-dev netcat && \
wget https://www.python.org/ftp/python/3.8.8/Python-3.8.8.tgz && \
tar -xvf Python-3.8.8.tgz && \
cd Python-3.8.8 && \
./configure --without-tests --enable-shared && \
make -j6 && \
make install && \
ldconfig /usr/local/lib && \
cd .. && rm -f Python-3.8.8.tgz && rm -rf Python-3.8.8 && \
ln -s /usr/local/bin/python3 /usr/local/bin/python && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# install PyFlink
RUN pip3 install apache-flink==1.20.0 --default-timeout=1000 --no-cache-dir