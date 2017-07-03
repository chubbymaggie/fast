#include <iostream>

#include "antlr4-runtime.h"
#include "smaliLexer.h"
#include "smaliParser.h"
#include "smaliBaseListener.h"

using namespace std;
using namespace antlr4;

class TreeShapeListener : public smaliBaseListener {
public:
	/*
  string current_identifier;
  string current_value;
  void enterObj(smaliParser::ObjContext *ctx) override {
	cout << "<" << ctx->getStart()->getText() << ">" << endl;
  }
  void exitObj(smaliParser::ObjContext *ctx) override {
	cout << "</" << ctx->getStart()->getText() << ">"<< endl;
  }
  void exitAttr(smaliParser::AttrContext *ctx) override {
	  current_identifier = ctx->getStart()->getText();
  }
  void exitValue(smaliParser::ValueContext *ctx) override {
	  current_value = ctx->getStart()->getText();
  }
  void exitPair(smaliParser::PairContext *ctx) override {
	cout << "<" << current_identifier << ">" << current_value << "</" << current_identifier << ">" << endl;
  }
  */
};

int main(int argc, const char* argv[]) {
  ifstream stream;
  stream.open(argv[1]);
  ANTLRInputStream input(stream);
  smaliLexer lexer(&input);
  CommonTokenStream tokens(&lexer);
  smaliParser parser(&tokens);
  tree::ParseTree *tree = parser.smali_file();
  TreeShapeListener listener;
  tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);

  return 0;
}
