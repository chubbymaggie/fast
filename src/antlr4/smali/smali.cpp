#include <iostream>

#include "antlr4-runtime.h"
#include "smaliLexer.h"
#include "smaliParser.h"
#include "smaliBaseListener.h"

using namespace std;
using namespace antlr4;

static vector<std::string> ruleNames;

string ctxName(ParserRuleContext *ctx) 
{
	string name = ruleNames[ctx->getRuleIndex()];
	transform(name.begin(), name.end(),name.begin(), ::tolower);
	return name;
}

static map<int, string> map_begin;
static map<int, string> map_end;

class TreeShapeListener : public smaliBaseListener {
public:
	void enterEveryRule(ParserRuleContext *ctx) {
		if (dynamic_cast<antlr4::tree::TerminalNode*>(ctx->getStart()))
			return;
		string name = ctxName(ctx);
		string open_tag = "";
		open_tag = open_tag + "<" + name + ">"; 
		int pos = ctx->getStart()->getStartIndex();
		map_begin[pos] = map_begin[pos] + open_tag;
	}

	void exitEveryRule(ParserRuleContext *ctx) {
		if (dynamic_cast<antlr4::tree::TerminalNode*>(ctx->getStop()))
			return;
		string name = ctxName(ctx);
		string close_tag = "";
		close_tag = close_tag + "</" + name + ">"; 
		int pos = ctx->getStop()->getStopIndex() + 1;
		map_end[pos] = map_end[pos] + close_tag;
	}
};

void printMarkups(FILE *file) {
	unsigned int c;
	int pos = -1;
	cout << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
	cout << "<unit>";
	int n_end = map_end.size();
	while ((c = fgetc(file))!= -1) {
		pos++;
		if (map_begin.find(pos) != map_begin.end()) {
			cout << map_begin[pos]; 
		}
		cout << (unsigned char) c;
		if (map_end.find(pos) != map_end.end()) {
			cout << map_end[pos]; 
			n_end --;
		} 
	}
	while (n_end > 0) {
		pos++;
		if (map_end.find(pos) != map_end.end()) {
			cout << map_end[pos]; 
			n_end--;
		} 
	}
	cout << "</unit>";
}

int main(int argc, const char* argv[]) {
  map_begin.clear();
  map_end.clear();

  ifstream stream;
  stream.open(argv[1]);
  ANTLRInputStream input(stream);
  smaliLexer lexer(&input);
  // voc = & (lexer.getVocabulary());
  CommonTokenStream tokens(&lexer);
  smaliParser parser(&tokens);
  ruleNames = parser.getRuleNames();
  tree::ParseTree *tree = parser.smali_file();
  TreeShapeListener listener;
  tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);
  FILE *file = fopen(argv[1], "r");
  printMarkups(file);
  fclose(file);
  return 0;
}
