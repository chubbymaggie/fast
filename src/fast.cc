#include <string.h>
#include <string>
#include <iostream>
#include <fstream>
#include <ostream>
#include "rapidxml.hpp"
#include "rapidxml_utils.hpp"
#include "rapidxml_print.hpp"
#include <locale>
#include <unistd.h>
#include <map>
#include <vector>
#ifdef FBS_fast
#include "flatbuffers/flatbuffers.h"
#include "flatbuffers/idl.h"
#include "flatbuffers/util.h"
#include "fast_generated.h"
#endif
#ifdef PB_fast
#include "fast.pb.h" 
#endif
#define GET_OPT
#ifdef GET_OPT
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#endif
#include <sys/stat.h> 
#include <srcSliceHandler.hpp>
#include <srcSlice.hpp>
#include <array>
using namespace std;
using namespace rapidxml;

#ifdef FBS_fast
using namespace _fast;
using namespace _fast::_Element;
using namespace _fast::_Element::_Literal;
using namespace _fast::_Element::_Unit;
#endif

#include "fast-option.h"

#ifdef PB_fast
fast::Element* savePBfromXML(xml_node<> *node);
void saveXMLfromPB(fstream &out, fast::Element *node);
#endif

#ifdef FBS_fast
flatbuffers::Offset<_fast::Element> saveFBSfromXML(flatbuffers::FlatBufferBuilder & builder, xml_node<> *node);
void saveXMLfromFBS(ofstream &out, const struct Element *element);
#endif


int loadSrcML(int load_only, int argc, char **argv);

int mainRoutine(int argc, char* argv[]);
int smaliMainRoutine(int argc, char** argv);
int pbMainRoutine(int argc, const char* argv[]);
int processMainRoutine(int argc, char**argv);
int sliceDiffMainRoutine(int argc, char**argv);

inline bool exists_test (const std::string& name) {
	struct stat buffer;   
	return (stat (name.c_str(), &buffer) == 0); 
}

bool check_exists(const std::string& name) {
	if (!exists_test(name)) {
		cerr << "Please check the input file " << name << " exists" << endl;
		return false;
	}
	return true;
}

void saveTxtFromPB(char *input_file);
void saveTxtFromPB(char *input_file, char *output_file);

void saveMarkupFromPB(char *input_file);
void saveMarkupFromPB(char *input_file, char *output_file);

int max_width = 0;

int loadXML(int load_only, int argc, char**argv) {
  if (!check_exists(argv[1])) return 1;
  char *input_filename = argv[1];
  char *output_filename = argv[2]; 
  bool is_protobuf = argc > 2 && strcmp(output_filename+strlen(output_filename)-3, ".pb")==0;
  bool is_flatbuffers = argc > 2 && strcmp(output_filename+strlen(output_filename)-4, ".fbs")==0;
  bool is_xml = argc > 2 && strcmp(output_filename+strlen(output_filename)-4, ".xml")==0;
  if (! load_only && is_xml) { // just copy the input to the output
	  string cmd = "cp ";
	  cmd = cmd + input_filename + " " + output_filename;
	  return system(cmd.c_str());
  }
  if (is_protobuf || is_flatbuffers) {
    xml_document<> doc;
    try {
	file<> xmlFile(input_filename);
        doc.parse<rapidxml::parse_no_entity_translation>(xmlFile.data());
#ifdef PB_fast
	if (is_protobuf) {
		fstream output(output_filename, ios::out | ios::trunc | ios::binary);
  		GOOGLE_PROTOBUF_VERIFY_VERSION;
		fast::Data *data = new fast::Data();
		fast::Element *element = savePBfromXML(doc.first_node());
		data->set_allocated_element(element);
		data->SerializeToOstream(&output);
  		google::protobuf::ShutdownProtobufLibrary();
		output.close();
		if (report_max_width) {
			cout << "The maximum width of tree nodes is :" << max_width << endl;
		}
	}
#endif
#ifdef FBS_fast
	if (is_flatbuffers) {
		flatbuffers::FlatBufferBuilder builder;
		auto element = saveFBSfromXML(builder, doc.first_node());
		auto anonymous = _fast::_Data::CreateAnonymous4(builder, element, 0, 0, 0);
		auto data = _fast::CreateData(builder, anonymous);
		builder.Finish(data);
		ofstream output(output_filename, ios::out | ios::trunc | ios::binary);
		long size = builder.GetSize();
		output.write((const char*) builder.GetBufferPointer(), size);
		output.close();
	}
#endif
    } catch(parse_error & e) {
        // std::cout << "Parse error: " << e.what() << std::endl << "At: " << e.where<char>() << std::endl;
    } catch(validation_error & e) {
        std::cout << "Validation error: " << e.what() << std::endl;
    }
  } else { // invoke srcml
    loadSrcML(load_only, argc, argv);
  }
  return 0;
}

#ifdef FBS_fast
void sliceFBS(srcSliceHandler& handler, const struct Element *element);
void srcSliceToCsv(const srcSlice& handler, const char* output_file);

int loadFBS(int load_only, int argc, char **argv) {
	if (!check_exists(argv[1])) return 1;
	char *filename = argv[1]; // the input file, which is assumed to be a binary flatbuffers
	FILE* file = fopen(filename, "rb");
	if (file == NULL) {
		cerr << "Warning: check the existence of " << filename << endl;
		return 1;
	}
	fseek(file, 0L, SEEK_END);
	int length = ftell(file);
	fseek(file, 0L, SEEK_SET);
	char *data = new char[length];
	fread(data, sizeof(char), length, file);
	fclose(file);
	const struct _fast::Data *d = flatbuffers::GetRoot<Data>(data);
	if (d != NULL && !load_only && !mySlice) {
		//string xml_filename = tmpnam(NULL);
		char buf[100];
		strcpy(buf, "/tmp/temp.XXXXXXXX"); 
		mkstemp(buf);
		remove(buf);
		string xml_filename = buf;
		remove(xml_filename.c_str());
		xml_filename +=	".xml";
		ofstream out(xml_filename, ios::out | ios::trunc);
		out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
		const struct _fast::Element *element = d->RecordType()->element();
		if (element != NULL) {
			saveXMLfromFBS(out, element);
		}
		out << endl;
		if (argc == 2) {
			if (slice) {
				string sliceCommand = "srcSlice ";
				sliceCommand = sliceCommand + xml_filename + " > " + xml_filename + ".slice";
				(void) system(sliceCommand.c_str());
				string catCommand = "cat ";
				catCommand = catCommand + xml_filename + ".slice";
				(void) system(catCommand.c_str());
				out.close();
				remove((xml_filename + ".slice").c_str());
			} else {
				string catCommand = "cat ";
				catCommand = catCommand + xml_filename;
				(void) system(catCommand.c_str());
			}
			out.close();
			return remove(xml_filename.c_str());
		}
		argv[1] = (char*) xml_filename.c_str();
		mainRoutine(argc, argv);
		return remove(xml_filename.c_str());
	} else if (d != NULL && !load_only && mySlice) {
		srcSlice sslice;
		srcSliceHandler handler(&sslice.dictionary);
		handler.startRoot(NULL, NULL, NULL, 0, NULL, 0, NULL);
		const struct _fast::Element *element = d->RecordType()->element();
		sliceFBS(handler, element);
		handler.endRoot(NULL, NULL, NULL);
		DoComputation(handler, handler.sysDict->ffvMap);
		if (argc > 2)
			srcSliceToCsv(sslice, argv[argc-1]);
		else
			srcSliceToCsv(sslice, NULL);
	}
 	return 0;
}
#endif

#ifdef PB_fast
void slicePB(srcSliceHandler& handler, fast::Element *element);

fast::Data readData(char *input_filename) {
	// Verify that the version of the library that we linked against is
	// compatible with the version of the headers we compiled against.
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data data;
	ifstream input(input_filename, ios::in | ios::binary);
    	if (!data.ParseFromIstream(&input)) {
	      cerr << "Failed to parse compilation unit." << endl;
	}
	input.close();
	return data;
}

int loadPB(int load_only, int argc, char **argv) {
	if (!check_exists(argv[1])) return 1;
	char *input_filename = argv[1];
	fast::Data data = readData(input_filename);
    if (data.has_element() && !load_only && !mySlice) {
	// string xml_filename = tmpnam(NULL);
	char buf[100];
	strcpy(buf, "/tmp/temp.XXXXXXXX"); 
	mkstemp(buf);
	remove(buf);
	string xml_filename = buf;
	xml_filename +=	".xml";
#if !defined(FBS_fast)
	fstream out(xml_filename.c_str(), ios::out | ios::trunc);
#else
	fstream out(xml_filename, ios::out | ios::trunc);
#endif
	out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
	fast::Element unit = data.element();
	saveXMLfromPB(out, &unit);
	out << endl;
	if (argc == 2) {
		if (slice) {
			string sliceCommand = "srcSlice ";
			sliceCommand = sliceCommand + xml_filename + " > " + xml_filename + ".slice";
			(void) system(sliceCommand.c_str());
			string catCommand = "cat ";
			catCommand = catCommand + xml_filename + ".slice";
			(void) system(catCommand.c_str());
			remove((xml_filename + ".slice").c_str());
		} else {
			string catCommand = "cat ";
			catCommand = catCommand + xml_filename;
			(void) system(catCommand.c_str());
		}
		return remove(xml_filename.c_str());
	}
	argv[1] = (char*) xml_filename.c_str();
	mainRoutine(argc, argv);
	return remove(xml_filename.c_str());
    } else if (data.has_element() && !load_only && mySlice) {
	srcSlice sslice;
	srcSliceHandler handler(&sslice.dictionary);
	handler.startRoot(NULL, NULL, NULL, 0, NULL, 0, NULL);
	fast::Element unit = data.element();
	slicePB(handler, &unit);
	handler.endRoot(NULL, NULL, NULL);
	DoComputation(handler, handler.sysDict->ffvMap);
	// cout << "argc = " << argc << " last arg = " << argv[argc-1] << endl;
	if (argc > 2)
		srcSliceToCsv(sslice, argv[argc-1]);
	else
		srcSliceToCsv(sslice, NULL);
    } 
  // Optional:  Delete all global objects allocated by libprotobuf.
  google::protobuf::ShutdownProtobufLibrary();
  return 0;
}

void slicePB(srcSliceHandler& handler, fast::Element *element) {
	string text = "";
	string tail = "";
	int k = element->kind();
	// cout << "k = " << k << endl;
	if (k == fast::Element_Kind_UNIT_KIND) {
		struct srcsax_attribute attrs[3];
		attrs[2].value = element->unit().filename().c_str();
		handler.startUnit(NULL, NULL, NULL, 0, NULL, 3, attrs);
	} else {
		struct srcsax_attribute attrs[1];
		attrs[0].value = std::to_string(element->line()).c_str();
		handler.startElement(k, NULL, NULL, 0, NULL, 1, attrs);
	}
	text = element->text();
	if (text!="") {
		handler.charactersUnit(text.c_str(), strlen(text.c_str()));
	}
	for (int i=0; i<element->child().size(); i++)
		slicePB(handler, element->mutable_child(i));
	if (k == fast::Element_Kind_UNIT_KIND) 
		handler.endUnit(NULL, NULL, NULL);
	else 
		handler.endElement(k, NULL, NULL);
	tail = element->tail();
	if (tail!="") {
		handler.charactersUnit(tail.c_str(), strlen(tail.c_str()));
	}
}
#endif

bool is_srcml = true;
bool is_smali_cpp = false;
#ifdef FBS_fast
void sliceFBS(srcSliceHandler& handler, const struct Element *element) {
	string text = "";
	string tail = "";
	int k = element->type()->kind();
	// cout << "k = " << k << endl;
	if (element->extra()) {
		if (k == 0) {
			struct srcsax_attribute attrs[3];
			if (element->extra()->unit()->filename()!=NULL) {
				attrs[2].value = element->extra()->unit()->filename()->c_str();
				handler.startUnit(NULL, NULL, NULL, 0, NULL, 3, attrs);
			}
		} 
	}
	if (element->text())
		text = element->text()->c_str();
        if ((!element->extra() && position) || (element->extra() && k !=0)) {
		struct srcsax_attribute attrs[1];
		attrs[0].value = std::to_string(element->line()).c_str();
		handler.startElement(k, NULL, NULL, 0, NULL, 1, attrs);
	}
	if (element->text())
		handler.charactersUnit(text.c_str(), strlen(text.c_str()));
	for (int i=0; i<element->child()->size(); i++)
		sliceFBS(handler, element->child()->Get(i));
	if (element->tail())
		tail = element->tail()->c_str();
	else 
		tail = "";
	if (element->extra())
		if (k == 0) 
			handler.endUnit(NULL, NULL, NULL);
		else 
			handler.endElement(k, NULL, NULL);
	else 
		handler.endElement(k, NULL, NULL);
	if (element->tail())
		handler.charactersUnit(tail.c_str(), strlen(tail.c_str()));
}

void saveXMLfromFBS(ofstream &out, const struct Element *element) {
	string tag;
	string attr;
	string text = "";
	string tail = "";
	if (element->extra()) {
		if (is_srcml && element->type()->kind() == 0) {
			tag = "unit";
			string str = string(EnumNamesLanguageType()[element->extra()->unit()->language()]);
			string lang = str;
			transform(str.begin(), str.end(),str.begin(), ::tolower);
			if (str == "cxx") {
				str = "cpp";
				lang = "C++";
			}
			if (str == "csharp") {
				str = "cpp";
				lang = "C#";
			}
			attr = attr + " xmlns=\"http://www.srcML.org/srcML/src\" xmlns:" + str + "=\"http://www.srcML.org/srcML/" + str + "\"";
			if (position)
				attr = attr + " xmlns:pos=\"http://www.srcML.org/srcML/position\"";
			attr = attr + " revision=\"" + element->extra()->unit()->revision()->c_str() + "\"";
			attr = attr + " language=\"" + lang + "\"";
			if (element->extra()->unit()->filename()!=NULL)
				attr = attr + " filename=\"" + element->extra()->unit()->filename()->c_str() + "\"";
		} else if (is_srcml && element->type()->kind() == 47) {
			tag = "literal";
			string type = EnumNamesLiteralType()[element->extra()->literal()->type()];
			type = type.substr(0, type.length() - 5);
			attr = attr + " type=\"" + type + "\"";
			if (position && (element->line()!=0 || element->column()!=0))
				attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
		} else {
			tag = EnumNamesKind()[element->type()->kind()];
			if (position && (element->line()!=0 || element->column()!=0))
				attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
		}
	} else {
		tag = EnumNamesKind()[element->type()->kind()];
		if (position && (element->line()!=0 || element->column()!=0))
			attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
	}
	if (element->text())
		text = element->text()->c_str();
	transform(tag.begin(), tag.end(), tag.begin(), ::tolower);
	out << "<" <<  tag <<  attr << ">" << text;
	for (int i=0; i<element->child()->size(); i++) {
		saveXMLfromFBS(out, element->child()->Get(i));
	}
	if (element->tail())
		tail = element->tail()->c_str();
	else 
		tail = "";
	out << "</" << tag << ">" << tail;
}
#endif

#ifdef PB_fast
void saveXMLfromPB(fstream & out, fast::Element *element) {
	string tag;
	string attr;
	string text = "";
	string tail = "";
	if (element->kind() == fast::Element_Kind_UNIT_KIND) {
		tag = "unit";
		string str = fast::Element_Unit_LanguageType_Name(element->unit().language());
		string lang = str;
		transform(str.begin(), str.end(),str.begin(), ::tolower);
		if (str == "cxx") {
			str = "cpp";
			lang = "C++";
		}
		if (str == "csharp") {
			str = "cpp";
			lang = "C#";
		}
		attr = attr + " xmlns=\"http://www.srcML.org/srcML/src\"";
		if (position)
			attr = attr + " xmlns:pos=\"http://www.srcML.org/srcML/position\"";
	        attr = attr + " xmlns:" + str + "=\"http://www.srcML.org/srcML/" + str + "\"";
		attr = attr + " revision=\"" + element->unit().revision().c_str() + "\"";
		attr = attr + " language=\"" + lang + "\"";
		attr = attr + " filename=\"" + element->unit().filename().c_str() + "\"";
	} else if (element->kind() == fast::Element_Kind_LITERAL) {
		tag = "literal";
		string type = fast::Element_Literal_LiteralType_Name(element->literal().type());
		type = type.substr(0, type.length() - 5);
		attr = attr + " type=\"" + type + "\"";
		if (position && (element->line()!=0 || element->column()!=0))
			attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
	} else {
		tag = fast::Element_Kind_Name(element->kind());
		if (position && (element->line()!=0 || element->column()!=0))
			attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
	}
	text = element->text();
	transform(tag.begin(), tag.end(), tag.begin(), ::tolower);
	out << "<" <<  tag <<  attr << ">" << text;
	for (int i=0; i<element->child().size(); i++) {
		saveXMLfromPB(out, element->mutable_child(i));
	}
	tail = element->tail();
	out << "</" << tag << ">" << tail;
}
#endif

void saveTxtFromPB(char *input_file, char *output_file) {
	char buf[1000];
	fast::Data data = readData(input_file);
	if (data.has_element()) {
		fast::Element unit = data.element();
		const char *filename = unit.unit().filename().c_str();
		if (json && jq && output_file==NULL) {
			sprintf(buf, "python /usr/local/share/fast-json.py %s | jq \"%s\"", 
				input_file, jq_query.c_str());
		} else if (json) {
			sprintf(buf, "python /usr/local/share/fast-json.py %s %s %s", 
				input_file, (output_file==NULL? "" : ">"), (output_file==NULL? "": output_file));
		} else {
			sprintf(buf, "cat %s | protoc -I/usr/local/share --decode=fast.Data /usr/local/share/fast.proto %s %s", 
				input_file, (output_file==NULL? "" : ">"), (output_file==NULL? "": output_file));
		}
		(void) system(buf);
	} else {
		if (json && jq && output_file==NULL) {
			sprintf(buf, "python /usr/local/share/fast-json.py %s | jq \"%s\"", 
				input_file, jq_query.c_str());
		} else if (json) {
			sprintf(buf, "python /usr/local/share/fast-json.py %s %s %s", 
				input_file, (output_file==NULL? "" : ">"), (output_file==NULL? "": output_file));
		} else {
			sprintf(buf, "cat %s | protoc -I/usr/local/share --decode=fast.Data /usr/local/share/fast.proto%s%s",
				input_file, (output_file==NULL? "" : ">"), (output_file==NULL? "": output_file));
		}
		(void) system(buf);
	} 
	if (pb2xml && output_file !=NULL ) {
		const char *my_argv[] = {
			"fast", output_file
		};
		(void) pbMainRoutine(2, my_argv);
	}
}
void saveTxtFromPB(char *input_file) {
	saveTxtFromPB(input_file, NULL);
}
void savePBfromTxt(char *input_file) {
	char buf[100];
	sprintf(buf, "cat %s | protoc -I/usr/local/share --encode=fast.Data /usr/local/share/fast.proto", input_file);
	(void) system(buf);
}
void savePBfromTxt(char *input_file, char *output_file) {
	char buf[1000];
	sprintf(buf, "cat %s | protoc -I/usr/local/share --encode=fast.Data /usr/local/share/fast.proto > %s", input_file, output_file);
	(void) system(buf);
}

map<string,vector<string>> id_comment_names;
string current_unit;
bool is_function_name;
bool is_not_function_name;

#ifdef PB_fast
fast::Element* savePBfromXML(xml_node<> *node)
{
	fast::Element *element = new fast::Element();
	fast::Element::Unit *unit;
	fast::Element::Literal *literal;
	string tag = node->name();
	bool is_unit = tag == string("unit");
	if (is_unit) {
		unit = new fast::Element_Unit();
		tag = tag + "_KIND";
	}
	bool is_literal = tag == string("literal");
	if (is_literal)
		literal = new fast::Element_Literal();
	if (tag != "") {
		for (xml_attribute<> *attr = node->first_attribute(); attr; attr = attr->next_attribute())
		{
			if (is_unit) {
				if (attr->name() == string("filename")) {
					unit->set_filename(attr->value());
					if (report_id_comment) {
						current_unit = attr->value();
					}
				}
				if (attr->name() == string("revision"))
					unit->set_revision(attr->value());
				if (attr->name() == string("language")) {
					fast::Element_Unit_LanguageType lang;
					string lan = attr->value();
					transform(lan.begin(), lan.end(),lan.begin(), ::toupper);
					if (lan == string("C++"))
						lan = "CXX";
					if (lan == string("C#"))
						lan = "CSHARP";
					bool success = fast::Element_Unit_LanguageType_Parse(lan, &lang);
					// cout << lang << " = " << lang << success << endl;
					unit->set_language(lang);
				}
				if (attr->name() == string("item")) {
					unit->set_item(atoi(attr->value()));
				}
			} else { 
			    if (is_literal) {
				if (attr->name() == string("type")) {
					fast::Element_Literal_LiteralType type;
					std::string value = attr->value();
				        value = value + "_type";
					bool success = fast::Element_Literal_LiteralType_Parse(value, &type);
					literal->set_type(type);
				}
			    }
			    if (attr->name() == string("pos:line")) {
				element->set_line(atoi(attr->value()));
			    }
			    if (attr->name() == string("pos:column")) {
				element->set_column(atoi(attr->value()));
			    }
			}
		}
		if (is_unit) element->set_allocated_unit(unit);
		if (is_literal)	element->set_allocated_literal(literal);
		fast::Element_Kind kind;
		string str = tag;
		transform(str.begin(), str.end(),str.begin(), ::toupper);
		fast::Element_Kind_Parse(str, &kind);
		element->set_kind(kind);
		if (report_id_comment) {
		       	if(kind == fast::Element_Kind_FUNCTION) {
				is_function_name = true;
			}
		       	if(kind == fast::Element_Kind_VARIABLE || 
				kind == fast::Element_Kind_TYPE || 
		       		kind == fast::Element_Kind_DECL) {
				is_not_function_name = true;
			}
		}
		xml_node<> *child = node->first_node();
		if (child != 0 && string(child->name()) == "") { // first text node
			element->set_text(child->value());
			if (report_id_comment && ((kind == fast::Element_Kind_NAME 
					&& is_function_name && !is_not_function_name)|| 
				kind == fast::Element_Kind_COMMENT)) { // NAME or COMMENT
				string text = child->value();
				if (kind == fast::Element_Kind_NAME && is_function_name
					&& !is_not_function_name) {
					id_comment_names[current_unit].push_back("id:"+text);
				} 
				if (kind == fast::Element_Kind_COMMENT) {
				    const char *str = text.c_str();
				    do {
					const char *begin = str;
					while( (*str <= 'Z' && *str >= 'A') || 
					       (*str <= 'z' && *str >= 'a') || 
					       (*str <= '9' && *str >= '0') || 
					       (*str == '_' || *str == '-'))
					    str++;
					if (begin < str)
						id_comment_names[current_unit].push_back("comment:"+string(begin, str));
				    } while (0 != *str++);
				}
			}
			if (report_id_comment && kind == fast::Element_Kind_NAME) {
				if (is_not_function_name) 
					is_not_function_name = false;
				else if (is_function_name) 
					is_function_name = false;
			}
		}
		int n = 0;
		while (child != 0){
			if (string(child->name()) != "") { // not text node
				fast::Element *child_element = savePBfromXML(child);
				element->add_child()->CopyFrom(*child_element);
			}
			child = child->next_sibling();
			n++;
		}
		if (node->next_sibling() != 0 && string(node->next_sibling()->name()) == "") { // sibling text node
			element->set_tail(node->next_sibling()->value());
		}
		if (report_max_width) {
			max_width = max(max_width, n);
			if (max_width > width_limit) {
			}
		}
		if (report_id_comment) {
			if (is_unit) {
				cout << current_unit << " ";
				for (string name: id_comment_names[current_unit]) {
					cout << name << " ";
				}
				cout << endl;
			}
		}
	} 
	return element;
}
#endif

static int pos = 0;
#ifdef FBS_fast
flatbuffers::Offset<_fast::Element> saveFBSfromXML(flatbuffers::FlatBufferBuilder & builder, xml_node<> *node) {
	string tag = node->name();
	bool is_unit = tag == string("unit");
	if (is_unit) {
		// unit = new fast::Element_Unit();
		tag = tag + "_KIND";
	}
	bool is_literal = tag == string("literal");
	flatbuffers::Offset<flatbuffers::String> text;
	flatbuffers::Offset<flatbuffers::String> tail;
	flatbuffers::Offset<flatbuffers::String> filename;
	flatbuffers::Offset<flatbuffers::String> revision;
	int language = 0;
	int item = -1;
	int type = 0;
	int line = 0;
	int column = 0;
	int length = 0;
	if (tag != "") {
		for (xml_attribute<> *attr = node->first_attribute(); attr; attr = attr->next_attribute())
		{
			if (is_unit) {
				if (attr->name() == string("filename")) 
					filename = builder.CreateString(string(attr->value()));
				if (attr->name() == string("revision"))
					revision = builder.CreateString(string(attr->value()));
				if (attr->name() == string("language")) {
					string lan = attr->value();
					transform(lan.begin(), lan.end(), lan.begin(), ::toupper);
					if (lan == string("C++"))
						lan = "CXX";
					if (lan == string("C#"))
						lan = "CSHARP";
					if (lan == string("OBJECTIVE-C"))
						lan = "OBJECTIVE_C";
					language = flatbuffers::LookupEnum(EnumNamesLanguageType(), lan.c_str());
				}
				if (attr->name() == string("item")) {
					item = atoi(attr->value());
				}
			}
			if (is_literal) {
				if (attr->name() == string("type")) {
					string t = attr->value(); 
					t = t + "_type";
					type = flatbuffers::LookupEnum(EnumNamesLiteralType(), t.c_str());
				}
			}
			if (attr->name() == string("pos:line")) {
				line = atoi(attr->value());
			}
			if (attr->name() == string("pos:column")) {
				column = atoi(attr->value());
			}
		}
		string str = tag;
		int32_t kind = -1;
		if (is_srcml) {
			transform(str.begin(), str.end(),str.begin(), ::toupper);
			kind = flatbuffers::LookupEnum(EnumNamesKind(), str.c_str());
		} else if (is_smali_cpp) {
			kind = flatbuffers::LookupEnum(EnumNamesSmaliKind(), str.c_str());
		}
		if (kind == -1)
			cerr << "Warning: the following kind is not found " << str << endl;
		flatbuffers::Offset<_fast::_Element::Anonymous1> extra = 0;
		if (is_unit || is_literal) {
			extra = CreateAnonymous1(builder, 
				CreateUnit(builder, filename, revision, language, item), 
				CreateLiteral(builder, type));
		}
		auto type = CreateAnonymous0(builder, is_srcml?kind:(int32_t)0, is_smali_cpp?kind:(int32_t)0);
		xml_node<> *child_node = node->first_node();
		if (child_node != 0 && string(child_node->name()) == "") { // first text node
			string str = string(child_node->value());
			text = builder.CreateString(str);
			length += str.length();
		}
		vector<flatbuffers::Offset<_fast::Element>> vec; 
		while (child_node != 0){
			if (string(child_node->name()) != "") { // not text node
				flatbuffers::Offset<_fast::Element> child_element = saveFBSfromXML(builder, child_node);
				vec.push_back(child_element);
			}
			child_node = child_node->next_sibling();
		}
		auto child = builder.CreateVector(vec);
		if (node->next_sibling() != 0 && string(node->next_sibling()->name()) == "") { // sibling text node
			string str = string(node->next_sibling()->value());
			length += str.length();
			tail = builder.CreateString(str);
		}
		auto element = _fast::CreateElement(builder, type, text, pos, length, child, tail, extra, line, column);
		pos += length;
		return element;
	} 
	return 0;
}
#endif

