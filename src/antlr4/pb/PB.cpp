#include <iostream>

#include "antlr4-runtime.h"
#include "PBLexer.h"
#include "PBParser.h"
#include "PBBaseListener.h"

using namespace std;
using namespace antlr4;

class TreeShapeListener : public PBBaseListener {
public:
  string current_identifier;
  string current_value;
  void enterObj(PBParser::ObjContext *ctx) override {
	cout << "<" << ctx->getStart()->getText() << ">" << endl;
  }
  void exitObj(PBParser::ObjContext *ctx) override {
	cout << "</" << ctx->getStart()->getText() << ">"<< endl;
  }
  void exitAttr(PBParser::AttrContext *ctx) override {
	  current_identifier = ctx->getStart()->getText();
  }
  void exitValue(PBParser::ValueContext *ctx) override {
	  current_value = ctx->getStart()->getText();
  }
  void exitPair(PBParser::PairContext *ctx) override {
	cout << "<" << current_identifier << ">" << current_value << "</" << current_identifier << ">" << endl;
  }
};

int main(int argc, const char* argv[]) {
  ifstream stream;
  stream.open(argv[1]);
  ANTLRInputStream input(stream);
  PBLexer lexer(&input);
  CommonTokenStream tokens(&lexer);
  PBParser parser(&tokens);
  tree::ParseTree *tree = parser.pb();
  TreeShapeListener listener;
  tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);

  return 0;
}
