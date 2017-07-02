PBX: PB.o PBLexer.o PBParser.o PBListener.o PBBaseListener.o
	c++ -o $@ $^ /usr/local/lib/libantlr4-runtime.a

%.o: %.cpp
	c++ -c -std=c++11 -IPB -I/usr/local/include/antlr4-runtime $^

%.o: PB/%.cpp
	c++ -c -std=c++11 -IPB -I/usr/local/include/antlr4-runtime $^

#	antlr4 -no-listener -o PB -Dlanguage=Cpp $^
PB/PBLexer.cpp PB/PBLexer.h PB/PBLexer.tokens PB/PBParser.cpp PB/PBParser.h: PB.g4
	antlr4 -o PB -Dlanguage=Cpp $^
	cat PBLexer.patch >> PB/PBLexer.cpp 
	sed -i -e 's/_modeNames;/_modeNames; static std::vector<std::string> _channelNames; const std::vector<std::string>\& getChannelNames() const override;/' PB/PBLexer.h

PB.cpp: PB/PBLexer.h
