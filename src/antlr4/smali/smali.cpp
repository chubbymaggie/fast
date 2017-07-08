#include <iostream>

#include "antlr4-runtime.h"
#include "smaliLexer.h"
#include "smaliParser.h"
#include "smaliParserBaseListener.h"

#include <vector>

#undef NOEXCEPT
#include "fast.pb.h"
#include <sys/stat.h>

using namespace std;
using namespace antlr4;

static vector<std::string> ruleNames;

string ctxName(ParserRuleContext *ctx) 
{
	string name = ruleNames[ctx->getRuleIndex()];
	transform(name.begin(), name.end(),name.begin(), ::tolower);
	return name;
}

static map<int, string> tag_map;
static map<int, vector<int>> type_map;
static bool xml_output = false;

class SmaliTreeShapeListener : public smaliParserBaseListener {
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
			if (close_pos == open_pos) {
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

void printMarkups(FILE *file, ofstream &out) {
	unsigned int c;
	int pos = -1;
	out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
	out << "<unit>";
	int n_end = tag_map.size();
	while ((c = fgetc(file))!= -1) {
		pos++;
		if (tag_map.find(pos) != tag_map.end()) {
			out << tag_map[pos]; 
			n_end --;
		}
		out << (unsigned char) c;
	}
	while (n_end > 0) {
		pos++;
		if (tag_map.find(pos) != tag_map.end()) {
			out << tag_map[pos]; 
			n_end--;
		} 
	}
	out << "</unit>";
}

/**
 * Generate the parsing tree into a protobuf representation
 */
void printMarkups(FILE *file, const char *output_file) {
	if (xml_output) { // output is xml
		ofstream out(output_file, ios::out | ios::trunc);
		printMarkups(file, out);
		out.close();
		return;
	}
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data *data = new fast::Data();
	fast::Element *element = data->mutable_element();
	fast::Element::Unit *unit = new fast::Element_Unit();
	element->set_allocated_unit(unit);
	unsigned int c;
	int pos = -1;
	int n_end = tag_map.size();
	vector<fast::Element*> path;
	path.push_back(element);
	string text = "";
	string tail = "";
	fast::Element *prev_element = NULL;
	while ((c = fgetc(file))!= -1) {
		pos++;
		if (type_map.find(pos) != type_map.end()) {
			vector<int> v = type_map[pos];
			for (int i = 0; i < v.size(); i++) {
				if (v[i] < 0) { // closing tag
					if (i == 0 && prev_element!=NULL) {
						prev_element->set_text(text);	
						prev_element = NULL;
					}
					if (i == v.size()-1 && prev_element == NULL) {
						prev_element = path.back();
					}
					path.pop_back();
				} else { // openning tag
					if (prev_element!=NULL) 
						prev_element->set_tail(text);
					fast::Element *child = path.back()->add_child();
					child->set_smali_kind((fast::SmaliKind)v[i]);
					path.push_back(child);
					if (i == v.size()-1) {
						prev_element = child;
					}
				}
				text = "";
			}
			n_end --;
		}
		text += c;
	}
	while (n_end > 0) {
		pos++;
		if (type_map.find(pos) != type_map.end()) {
			vector<int> v = type_map[pos];
			for (int i = 0; i < v.size(); i++) {
				if (v[i] < 0) { // closing tag
					if (i == 0 && prev_element!=NULL) {
						prev_element->set_text(text);	
						prev_element = NULL;
					}
					if (i == v.size()-1 && prev_element == NULL) {
						prev_element = path.back();
					}
					path.pop_back();
				} else { // openning tag
					if (prev_element!=NULL) 
						prev_element->set_tail(text);
					fast::Element *child = path.back()->add_child();
					child->set_kind((fast::Element_Kind) v[i]);
					path.push_back(child);
					if (i == v.size()-1) {
						prev_element = child;
					}
				}
				text = "";
			}
			n_end--;
		} 
	}
	fstream output(output_file, ios::out | ios::trunc | ios::binary);
	data->SerializeToOstream(&output);
  	google::protobuf::ShutdownProtobufLibrary();
	output.close();
}

int smaliMainRoutine(int argc, char**argv) {
  tag_map.clear();
  ifstream stream;
  bool is_smali = strcmp(argv[1]+strlen(argv[1])-6, ".smali")==0;
  bool input_is_pb = strcmp(argv[1]+strlen(argv[1])-3, ".pb")==0;
  bool output_is_pb = argc > 2 && strcmp(argv[2]+strlen(argv[2])-3, ".pb")==0;
  if (!output_is_pb)
	  xml_output = true;
  stream.open(argv[1]);
  ANTLRInputStream input(stream);
  smaliLexer lexer(&input);
  // voc = & (lexer.getVocabulary());
  CommonTokenStream tokens(&lexer);
  smaliParser parser(&tokens);
  ruleNames = parser.getRuleNames();
  struct stat buf;
  if (stat("smali.proto", &buf) == -1) {
	  fstream proto_output("smali.proto", ios::out);
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
  tree::ParseTree *tree = parser.smali_file();
  tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);
  FILE *file = fopen(argv[1], "r");
  if (argc == 2) {
	  printMarkups(file, (ofstream&) cout);
  } else { // assume that the second argument for FAST representation
	  printMarkups(file, argv[2]);
  }
  fclose(file);
  return 0;
}
