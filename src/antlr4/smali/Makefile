fast-smali: smaliLexer.o smaliParser.o smaliListener.o smaliBaseListener.o smali.o 
	c++ -o $@ $^ /usr/local/lib/libantlr4-runtime.a

%.o: smali/%.cpp
	c++ -c -std=c++11 -Ismali -I/usr/local/include/antlr4-runtime $^

%.o: %.cpp
	c++ -c -std=c++11 -Ismali -I/usr/local/include/antlr4-runtime $^

smali/smaliParser.cpp smali/smaliParser.h smali/smaliListener.cpp smali/smaliBaseListener.cpp: smali.g4
	antlr4 -o smali -Dlanguage=Cpp $^

smali/smaliLexer.cpp smali/smaliLexer.h smali/smaliLexer.tokens: smaliLexer.g4
	antlr4 -o smali -Dlanguage=Cpp $^
	cat smaliLexer.patch >> smali/smaliLexer.cpp 
	sed -i -e 's/_modeNames;/_modeNames; static std::vector<std::string> _channelNames; const std::vector<std::string>\& getChannelNames() const override;/' smali/smaliLexer.h

smali.cpp: smali/smaliLexer.h

clean:: 
	rm -rf fast-smali *.o smali
