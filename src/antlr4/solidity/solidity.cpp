#include <iostream>

#include "antlr4-runtime.h"
#include "SolidityLexer.h"
#include "SolidityParser.h"
#include "SolidityBaseListener.h"

#include <vector>

#undef NOEXCEPT
#include "fast.pb.h"
#include <sys/stat.h>
#include "rapidxml.hpp"
#include "rapidxml_utils.hpp"
#include "rapidxml_print.hpp"
#include "fast_generated.h"

using namespace std;
using namespace rapidxml;
using namespace antlr4;

extern vector<std::string> ruleNames;
extern bool parse_only;

string ctxName(ParserRuleContext *ctx);

extern map<int, string> tag_map;
extern map<int, vector<int>> type_map;
extern bool xml_output;

class SmaliTreeShapeListener : public SolidityBaseListener {
public:
	void exitEveryRule(ParserRuleContext *ctx) {
		if (dynamic_cast<antlr4::tree::TerminalNode*>(ctx->getStop()))
			return;
		if (!xml_output) {
			int tag = ctx->getRuleIndex();
			int open_tag = tag; 
			int close_tag = -tag; 
			int open_pos = ctx->getStart()->getStartIndex();
			int close_pos = ctx->getStop()->getStopIndex() + 1;
			if (close_pos == open_pos) {
				type_map[open_pos].push_back(open_tag); 
				type_map[open_pos].push_back(close_tag); 
			} else {
				if (type_map[open_pos].empty()) 
					type_map[open_pos].push_back(open_tag);
				else if (type_map[open_pos][0] > 0)
					type_map[open_pos].insert(type_map[open_pos].begin(), open_tag);
				else
					type_map[open_pos].push_back(open_tag);
				if (type_map[close_pos].empty()) 
					type_map[close_pos].push_back(close_tag);
				else if (type_map[close_pos].back() > 0) { 
					type_map[close_pos].insert(type_map[close_pos].begin(), close_tag);
				} else {
					type_map[close_pos].push_back(close_tag);
				}
			}
		} else {
			string name = ctxName(ctx);
			string open_tag = "<" + name + ">"; 
			string close_tag = "</" + name + ">"; 
			int open_pos = ctx->getStart()->getStartIndex();
			int close_pos = ctx->getStop()->getStopIndex() + 1;
			if (close_pos <= open_pos) {
				tag_map[open_pos] = tag_map[open_pos] + open_tag + close_tag;
			} else {
				if (tag_map[open_pos] == "") 
					tag_map[open_pos] = open_tag;
				else if (tag_map[open_pos].find("</")!=0)
					tag_map[open_pos] = open_tag + tag_map[open_pos];
				else
					tag_map[open_pos] = tag_map[open_pos] + open_tag;
				if (tag_map[close_pos] == "") 
					tag_map[close_pos] = close_tag;
				else if (tag_map[close_pos].rfind("</") != string::npos) { 
					string tail = tag_map[close_pos].substr(tag_map[close_pos].rfind("</")+2);
					if (tail.find("<")!=string::npos) {
						// tail is openning tag
						tag_map[close_pos] = close_tag + tag_map[close_pos];
					} else {
						tag_map[close_pos] = tag_map[close_pos] + close_tag;
					}
				} else {
					tag_map[close_pos] = close_tag + tag_map[close_pos];
				}
			}
		}
	}
};

void printMarkups(FILE *file, ofstream &out, bool is_Solidity);

flatbuffers::Offset<_fast::Element> saveFBSfromXML(flatbuffers::FlatBufferBuilder & builder, xml_node<> *node);
/**
 * Generate the parsing tree into a protobuf representation
 */
void printMarkups(FILE *file, const char *output_file, bool is_Solidity);

int SolidityMainRoutine(int argc, char**argv) {
  tag_map.clear();
  ifstream stream;
  bool is_Solidity = strcmp(argv[1]+strlen(argv[1])-4, ".sol")==0;
  bool input_is_pb = strcmp(argv[1]+strlen(argv[1])-3, ".pb")==0;
  bool output_is_pb = argc > 2 && strcmp(argv[2]+strlen(argv[2])-3, ".pb")==0;
  bool output_is_fbs = argc > 2 && strcmp(argv[2]+strlen(argv[2])-4, ".fbs")==0;
  if (!output_is_pb && !output_is_fbs)
	  xml_output = true;
  stream.open(argv[1]);
  ANTLRInputStream input(stream);
  SolidityLexer lexer(&input);
  // voc = & (lexer.getVocabulary());
  CommonTokenStream tokens(&lexer);
  SolidityParser parser(&tokens);
  ruleNames = parser.getRuleNames();
  struct stat buf;
  if (stat("Solidity.proto", &buf) == -1) {
	  fstream proto_output("Solidity.proto", ios::out);
	  proto_output << "syntax=\"proto3\";" << endl;
	  proto_output << "enum Kind {" << endl;
	  for (int i =0; i < parser.getRuleNames().size(); i++) {
		string name = parser.getRuleNames()[i];
		transform(name.begin(), name.end(),name.begin(), ::tolower);
		proto_output << "\t" << name << " = " << i << ";" << endl; 
	  }
	  proto_output << "}" << endl;
	  proto_output.close();
  }
  SmaliTreeShapeListener listener;
  parser.removeErrorListeners();
  tree::ParseTree *tree = parser.sourceUnit();
  tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);
  FILE *file = fopen(argv[1], "r");
  if (argc == 2) {
	  if (!parse_only)
		  printMarkups(file, (ofstream&) cout, is_Solidity);
  } else { // assume that the second argument for FAST representation
	  printMarkups(file, argv[2], is_Solidity);
  }
  fclose(file);
  return 0;
}
