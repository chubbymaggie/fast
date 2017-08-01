FROM ubuntu
ENV LD_LIBRARY_PATH /usr/local/lib
RUN apt-get update
RUN apt-get install apt-transport-https -y
RUN echo deb https://yijunyu.github.io/ubuntu ./ >> /etc/apt/sources.list
RUN apt-get install gcc-5 g++-5 -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 1
RUN apt-get install uuid-dev -y
RUN apt-get update
#RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get install -y --force-yes srcml
RUN apt-get install libarchive13 -y
RUN apt-get install libxml2 -y
RUN apt-get install wget -y
RUN apt-get install cmake -y
RUN wget https://github.com/google/flatbuffers/archive/v1.6.0.tar.gz && tar xvfz v1.6.0.tar.gz && cd flatbuffers-1.6.0 && cmake . && make && make install && cd - && rm -rf flatbuffers-1.6.0
RUN wget https://github.com/google/protobuf/releases/download/v3.3.0/protobuf-cpp-3.3.0.tar.gz && tar xvfz protobuf-cpp-3.3.0.tar.gz && cd protobuf-3.3.0 && ./configure && make && make install && cd - && rm -rf protobuf-3.3.0
RUN apt-get install git -y
RUN apt-get install libxml2-dev -y
RUN git clone --recursive https://github.com/srcml/srcSlice && cd srcSlice/srcSAX && mkdir build && cd build && cmake .. && make && cp bin/libsrcsax.* /usr/local/lib/ && cd ../../..
RUN apt-get install jq -y
RUN apt-get install python-pip -y
RUN pip install protobuf
RUN pip install --user cpp-coveralls
RUN apt-get install -y unzip
RUN apt-get install pkg-config -y
RUN wget http://www.antlr.org/download/antlr4-cpp-runtime-4.7-source.zip && mkdir antlr4-cpp-runtime && cd antlr4-cpp-runtime && unzip ../antlr4-cpp-runtime-4.7-source.zip && sed -i -e '/CMP0059/d' CMakeLists.txt && cmake . && make && make install && cd .. && rm -rf antlr4-cpp-runtime
RUN wget http://www.antlr.org/download/antlr-4.7-complete.jar && mv antlr-4.7-complete.jar /usr/local/lib
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN git clone https://github.com/f-ast/fast && cd fast && make && make install
