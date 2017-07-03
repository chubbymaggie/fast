OPT=-g -O0 -coverage
OPT=-O3
CFLAGS+=-I../../ -I/usr/local/include -Ismali -I/usr/local/include/antlr4-runtime -std=c++11

fast-smali: smaliLexer.o smaliParser.o smaliListener.o smaliBaseListener.o smali.o fast.pb.o
	c++ $(OPT) $(CFLAGS) -o $@ $^ /usr/local/lib/libantlr4-runtime.a /usr/local/lib/libprotobuf.a

fast.pb.o: ../../fast.pb.cc 
	c++ $(OPT) $(CFLAGS) -c $^

%.o: smali/%.cpp
	c++ $(OPT) $(CFLAGS) -c $^

%.o: %.cpp
	c++ $(OPT) $(CFLAGS) -c $^

smali/smaliParser.cpp smali/smaliParser.h smali/smaliListener.cpp smali/smaliBaseListener.cpp: smali.g4
	antlr4 -o smali -Dlanguage=Cpp $^

smali/smaliLexer.cpp smali/smaliLexer.h smali/smaliLexer.tokens: smaliLexer.g4
	antlr4 -o smali -Dlanguage=Cpp $^
	cat smaliLexer.patch >> smali/smaliLexer.cpp 
	sed -i -e 's/_modeNames;/_modeNames; static std::vector<std::string> _channelNames; const std::vector<std::string>\& getChannelNames() const override;/' smali/smaliLexer.h

smali.cpp: smali/smaliLexer.h

clean:: 
	rm -rf fast-smali *.o smali
