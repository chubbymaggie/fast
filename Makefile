UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	gtime=/usr/bin/time
	target+=fast_pb fast_fbs
	CXX=g++
endif
ifeq ($(UNAME_S),Darwin)
	gtime=gtime
	target+=fast fast-debug
	CXX=c++
endif

OPT_DEBUG=-g
OPT=-O3

FBS_LIB=-L/usr/local/lib -lflatbuffers
PB_LIB=$(shell pkg-config --libs protobuf)

target+=fast_generated.h _fast/Element.py
target+=fast.pb.h fast.pb.cc

all: $(target)

ifeq ($(UNAME_S),Linux)
fast.cc: fast.pb.h fast.pb.cc
fast.cc: fast_generated.h
fast_pb: fast.cc
	$(CXX) $(OPT) -DPB_fast -I/usr/local/include -Irapidxml $^ /usr/local/lib/libprotobuf.a -o $@

fast_fbs: fast.cc
	$(CXX) $(OPT) -std=c++11 -DFBS_fast -I/usr/local/include -Irapidxml $(FBS_LIB) $^ -o $@

install: fast_pb fast_fbs
	cp fast_pb /usr/local/bin/
	cp fast_fbs /usr/local/bin/
	cp fast.sh /usr/local/bin/fast
endif

ifeq ($(UNAME_S),Darwin)
fast: fast.cc
	$(CXX) $(OPT) -std=c++11 -DPB_fast -DFBS_fast -I/usr/local/include -Irapidxml $(PB_LIB) $(FBS_LIB) $^ -o $@

fast-debug: fast.cc
	$(CXX) $(OPT_DEBUG) -std=c++11 -DPB_fast -DFBS_fast -I/usr/local/include -Irapidxml $(PB_LIB) $(FBS_LIB) $^ -o $@

install: fast
	cp fast /usr/local/bin/

endif

./protobuf-3.2.0/src/protoc: protobuf-3.2.0
	cd protobuf-3.2.0
	./configure CXXFLAGS=-std=c++11
	make
	sudo make install

protobuf-3.2.0:
	wget https://github.com/google/protobuf/releases/download/v3.2.0/protobuf-cpp-3.2.0.tar.gz
	tar xvfz protobuf-cpp-3.2.0.tar.gz

./googletest/googlemock/gtest/libgtest.a: googletest
	cd googletest
	cmake .
	make CXXFLAGS=-std=c++11
	sudo make install

./googletest/googlemock/libgmock.a: ./googletest/googlemock/gtest/libgtest.a
	cd googletest/googlemock
	cmake .
	make CXXFLAGS=-std=c++11
	sudo make install

srcML-src.tar.gz: 
	wget http://131.123.42.38/lmcrs/beta/srcML-src.tar.gz

srcML-src: srcML-src.tar.gz
	tar xvfz $^

./srcML-src/build/bin/srcml: srcML-src/
	cd srcML-src
	cmake .
	make
	sudo make install

%.json: __main__.py %.pb
	python $^ $@

%.pb: __main__.py %.xml
	python $^ $@

%.pb.xml: __main__.py %.pb
	python $^ $@

%.pb.cc: __main__.py %.pb
	python $^ $@

%.xml: %.cc
	srcml $^ -o $@

__main__.py: ./protobuf-3.2.0/src/protoc fast_pb2.py

fast_pb2.py: ./protobuf-3.2.0/src/protoc fast.proto
	protoc -I=. --python_out=. fast.proto

fast.pb.h fast.pb.cc: fast.proto
	protoc -I=. --cpp_out=. fast.proto

fast.fbs: fast.proto
	flatc --proto fast.proto

_fast/Element.py: fast.fbs
	flatc -p -o . fast.fbs

fast_generated.h: fast.fbs
	flatc --cpp -o . fast.fbs

fast.proto.in: ElementType.proto \
	Unit.proto Literal.proto
	touch $@

Unit.proto.in: LanguageType.proto
	touch $@

Literal.proto.in: LiteralType.proto
	touch $@

%: %.in
	cpp -E -P $*.in | grep -v "^[ ]*$$" | grep -v "^0$$" > $@

test%: benchmarks/Hello8192/Hello%.java
	${gtime} -f%e srcml $^ -o /tmp/Hello$*.xml
	${gtime} -f%e srcml $^ -o /dev/null
	${gtime} -f%e srcml $^ -S -o /dev/null
	${gtime} -f%e srcml $^ -X -o /dev/null

benchmarks/Hello8192/%8192.java: /tmp/%4096.java
	cat $^ $^ > $@
%4096.java: %2048.java
	cat $^ $^ > $@
%2048.java: %1024.java
	cat $^ $^ > $@
%1024.java: %512.java
	cat $^ $^ > $@
%512.java: %256.java
	cat $^ $^ > $@
%256.java: %128.java
	cat $^ $^ > $@
%128.java: %64.java
	cat $^ $^ > $@
%64.java: %32.java
	cat $^ $^ > $@
%32.java: %16.java
	cat $^ $^ > $@
%16.java: %8.java
	cat $^ $^ > $@
%8.java: %4.java
	cat $^ $^ > $@
%4.java: %2.java
	cat $^ $^ > $@
/tmp/%2.java: benchmarks/Hello/%.java
	cat $^ $^ > $@

clean:
	rm -f $(target) test/*.fbs test/*.pb test/*.xml
