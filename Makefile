V0=0.0.2
V=0.0.3
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	gtime=/usr/bin/time
SRCSAX_LIB=/usr/local/lib/libsrcsax.a -L/usr/lib/x86_64-linux-gnu $(shell xml2-config --libs)
endif
ifeq ($(UNAME_S),Darwin)
	gtime=gtime
SRCSAX_LIB=/usr/local/lib/libsrcsax.a $(shell xml2-config --libs)
endif

target+=fast
target+=process
target+=slice-diff
CXX=c++
protoc=/usr/local/bin/protoc
flatc=/usr/local/bin/flatc

OPT=-O3
OPT=-g
OPT=-g -O0 -coverage
ifeq ($(UNAME_S),Linux)
ANTLR4="java -jar /usr/local/lib/antlr-4.7-complete.jar"
ANTLR4_LIB=/usr/local/lib/libantlr4-runtime.a 
ANTLR4_INCLUDE=-I/usr/local/include
else
ANTLR4=/usr/local/Cellar/antlr/4.7/bin/antlr4
ANTLR4_LIB=/usr/local/Cellar/antlr4-cpp-runtime/4.7/lib/libantlr4-runtime.a
ANTLR4_INCLUDE=-Isrc/antlr4-runtime
endif

FBS_LIB=-L/usr/local/lib -lflatbuffers
PB_LIB=$(shell pkg-config --libs protobuf)
PB_LIB=-L/usr/local/lib -lprotobuf

CFLAGS+=-Isrc -I/usr/local/include $(ANTLR4_INCLUDE) -Ismali/src/antlr4/smali -I/usr/local/include/antlr4-runtime -std=c++11
LDFLAGS+=$(ANTLR4_LIB)

all: $(target)

./process: process.o fast.pb.o
	c++ $(OPT) $^ $(PB_LIB) -o $@

./slice-diff: slice-diff.o fast.pb.o
	c++ $(OPT) $^ $(PB_LIB) -o $@

fast.pb.o: src/fast.pb.cc 
	c++ $(OPT) $(CFLAGS) -c $^

%.o: smali/src/antlr4/smali/%.cpp
	c++ $(OPT) $(CFLAGS) -c $^

%.o: src/antlr4/smali/%.cpp
	c++ $(OPT) $(CFLAGS) -c $^

smali/src/antlr4/smali/smaliParser.cpp smali/src/antlr4/smali/smaliParser.h smali/src/antlr4/smali/smaliParserListener.cpp smali/src/antlr4/smali/smaliParserBaseListener.cpp: src/antlr4/smali/smaliParser.g4
	$(ANTLR4) -o smali -Dlanguage=Cpp $^

smali/src/antlr4/smali/smaliLexer.cpp smali/src/antlr4/smali/smaliLexer.h smali/src/antlr4/smali/smaliLexer.tokens: src/antlr4/smali/smaliLexer.g4
	$(ANTLR4) -o smali -Dlanguage=Cpp $^

src/antlr/smali/smali.cpp: smali/src/antlr4/smali/smaliLexer.h

src/fast.cc: src/rapidxml/rapidxml.hpp src/fast_generated.h src/fast.pb.h src/ver.h
	touch $@

fast-$V.tar.gz:
ifeq ($(UNAME_S),Linux)
	sudo pip install git-archive-all
endif
ifeq ($(UNAME_S),Darwin)
	brew install git-archive-all
endif
	git archive-all $@

DESTDIR=

ifeq ($(UNAME_S),Linux)
CFLAGS+=-std=c++11 -DPB_fast -DFBS_fast -I/usr/local/include -I/usr/include -I/usr/local/include -Isrc/rapidxml -Isrc -Isrc/headers -Isrc/cpp
CFLAGS+=$(shell xml2-config --cflags)

prefix=/usr/local
fast: fast.o fast.pb.o srcSlice.o srcSliceHandler.o output.o git.o smaliLexer.o smaliParser.o smaliParserListener.o smaliParserBaseListener.o smali.o
	$(CXX) $(OPT) $(CFLAGS) $^ /usr/local/lib/libprotobuf.a $(PB_LIB) $(FBS_LIB) $(SRCSAX_LIB) $(LDFLAGS) -o $@

install: fast process fast.proto
	mkdir -p $(DESTDIR)$(prefix)/bin
	mkdir -p $(DESTDIR)$(prefix)/lib
	mkdir -p $(DESTDIR)$(prefix)/share
	install -m 0755 fast $(DESTDIR)$(prefix)/bin/fast
	install -m 0755 process $(DESTDIR)$(prefix)/bin/process
	install -m 0755 bin/apk2pb $(DESTDIR)$(prefix)/bin/apk2pb
	install -m 0644 fast.proto $(DESTDIR)$(prefix)/share/fast.proto
	if [ ! -f srcslice ]; then wget https://yijunyu.github.io/ubuntu/srcslice; fi
	install -m 0755 srcslice $(DESTDIR)$(prefix)/bin/srcSlice

endif

ifeq ($(UNAME_S),Darwin)
prefix=$(HOMEBREW_FORMULA_PREFIX)
ifeq ($(prefix),)
prefix=/usr/local
endif

CFLAGS+=-std=c++11 -DPB_fast -DFBS_fast -I/usr/include -I/usr/local/include -Isrc/rapidxml -Isrc -Isrc/headers -Isrc/cpp 
CFLAGS+=$(shell xml2-config --cflags)

fast: fast.o fast.pb.o srcSlice.o srcSliceHandler.o output.o git.o smaliLexer.o smaliParser.o smaliParserListener.o smaliParserBaseListener.o smali.o
	$(CXX) $(OPT) $(CFLAGS) $(PB_LIB) $(FBS_LIB) $(SRCSAX_LIB) $(LDFLAGS) $^ -o $@

src/cpp/srcSliceHandler.cpp: src/srcSliceHandler.hpp
	touch $@

install: fast process fast.proto
	mkdir -p $(DESTDIR)$(prefix)/bin
	mkdir -p $(DESTDIR)$(prefix)/lib
	mkdir -p $(DESTDIR)$(prefix)/share
	install -m 0755 fast $(DESTDIR)$(prefix)/bin/fast
	install -m 0755 process $(DESTDIR)$(prefix)/bin/process
	install -m 0755 bin/apk2pb $(DESTDIR)$(prefix)/bin/apk2pb
	install -m 0644 fast.proto $(DESTDIR)$(prefix)/share/fast.proto
	install -m 0755 lib/osx/srcSlice $(DESTDIR)$(prefix)/bin/srcSlice
	install -m 0755 lib/osx/libsrcsax.dylib $(DESTDIR)$(prefix)/lib/libsrcsax.dylib
	install -m 0755 lib/osx/libsrcml.dylib $(DESTDIR)$(prefix)/bin/libsrcml.dylib
endif
.PHONY: install

srcML-src.tar.gz: 
	wget http://131.123.42.38/lmcrs/beta/srcML-src.tar.gz

srcML-src: srcML-src.tar.gz
	tar xvfz $^

./srcML-src/build/bin/srcml: srcML-src/
	cd srcML-src; cmake .; make; sudo make install

%.json: __main__.py %.pb
	python $^ $@

%.pb: __main__.py %.xml
	python $^ $@

%.pb.xml: __main__.py %.pb
	python $^ $@

%.pb.cc: __main__.py %.pb
	python $^ $@

%.o: src/%.cc
	c++ $(OPT) -c $(CFLAGS) $^ -o $@

%.o: src/cpp/%.cpp
	c++ $(OPT) -c $(CFLAGS) $^ -o $@

__main__.py: fast_pb2.py

src/fast_pb2.py: fast.proto
	$(protoc) -I=. --python_out=src fast.proto

src/fast.pb.h src/fast.pb.cc: fast.proto
	$(protoc) -I=. --cpp_out=src fast.proto

fast.fbs: fast.proto
	$(flatc) --proto fast.proto

_fast/Element.py: fast.fbs
	$(flatc) -p -o . fast.fbs

src/fast_generated.h: fast.fbs
	$(flatc) --cpp -o src fast.fbs

src/fast.proto.in: ElementType.proto Smali.proto \
	Unit.proto Literal.proto \
	log.proto

src/log.proto.in: author.proto commit.proto

src/commit.proto.in: diff.proto

src/diff.proto.in: hunk.proto

src/hunk.proto.in: modline.proto

src/Unit.proto.in: LanguageType.proto

src/Literal.proto.in: LiteralType.proto

%: src/%.in
	cpp -I. -E -P $^ | grep -v "^[ ]*$$" | grep -v "^0$$" > $@

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
	rm -f fast.cc fast_pb2.py fast.fbs
	rm -rf $(target) *.proto *.dSYM	_fast/ *.o HEAD
	rm -rf Release autom4te.cache config.h config.log config.status configure.scan
	rm -rf protobuf-3.3.0 protobuf-cpp-3.3.0.tar.gz
	rm -rf fast_*-1* fast-*
	rm -f *.gcno *.gcov *.gcda
	rm -rf fast.info index*.html *.png v1/ gcov.css Users usr

release::
	git tag -f v$V
	git push -f origin v$V
ifeq ($(UNAME_S),Darwin)
	rm -f ${HOME}/Library/Caches/Homebrew/fast-$V.tar.gz
	rm -f ${HOME}/Library/Caches/Homebrew/fast-$V.sierra.bottle.tar.gz
endif

v$V.tar.gz:
	wget https://github.com/yijunyu/fast/archive/v$(V0).tar.gz
	wget https://github.com/yijunyu/fast/archive/v$V.tar.gz

debian: fast-$V/debian/source/format fast-$V/debian/rules fast-$V/debian/copyright fast-$V/debian/control fast-$V/debian/changelog fast-$V/debian/compat
	cd fast-$V && dpkg-source --commit
	cd fast-$V && debuild -S	
#	dpkg-buildpackage -b

fast_%.orig.tar.gz: v%.tar.gz
	mv $^ $@

fast-$V: fast_$V.orig.tar.gz fast_$(V0).orig.tar.gz
	tar xf fast_$V.orig.tar.gz 
	tar xf fast_$(V0).orig.tar.gz
	rm -rf fast-$V/lib

fast-$V/debian: fast-$V
	mkdir -p $@

fast-$V/debian/changelog: changelog
	cp $^ $@

fast-$V/debian/compat: fast-$V/debian
	echo 9 > $@

fast-$V/debian/control: control
	cp $^ $@

fast-$V/debian/copyright: copyright
	cp $^ $@

fast-$V/debian/source/format: format
	mkdir -p fast-$V/debian/source
	cp $^ $@

fast-$V/debian/rules: rules
	cp $^ $@

test:: install
	cd test && ./test.sh

src/ver.h: src/version.h.in
	sed -e 's/GIT_TAG_VERSION/$(shell git tag | tail -1)/' $^ | sed -e 's/GIT_CURRENT/$(shell git rev-parse HEAD)/' | sed -e 's/GIT_WORK_COPY/$(shell git diff HEAD | shasum -a 256 | cut -d " " -f1)/' > $@
