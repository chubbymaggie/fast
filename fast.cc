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
#ifdef FBS_fast
#include "flatbuffers/flatbuffers.h"
#include "flatbuffers/idl.h"
#include "flatbuffers/util.h"
#include "fast_generated.h"
#endif
#ifdef PB_fast
#include "fast.pb.cc" 
#endif

using namespace std;
using namespace rapidxml;

#ifdef FBS_fast
using namespace _fast;
using namespace _fast::_Element;
using namespace _fast::_Element::_Literal;
using namespace _fast::_Element::_Unit;
#endif

#ifdef PB_fast
fast::Element* savePBfromXML(xml_node<> *node);
void saveXMLfromPB(fstream &out, fast::Element *node);
#endif

#ifdef FBS_fast
flatbuffers::Offset<_fast::Element> saveFBSfromXML(flatbuffers::FlatBufferBuilder & builder, xml_node<> *node);
void saveXMLfromFBS(fstream &out, const struct Element *element);
#endif

int mainRoutine(int argc, char* argv[]);

int loadXML(bool load_only, int argc, char**argv) {
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
        doc.parse<0>(xmlFile.data());
#ifdef PB_fast
	if (is_protobuf) {
		fstream output(output_filename, ios::out | ios::trunc | ios::binary);
  		GOOGLE_PROTOBUF_VERIFY_VERSION;
		fast::Element * element = savePBfromXML(doc.first_node());
		element->SerializeToOstream(&output);
  		google::protobuf::ShutdownProtobufLibrary();
		output.close();
	}
#endif
#ifdef FBS_fast
	if (is_flatbuffers) {
		flatbuffers::FlatBufferBuilder builder;
		auto element = saveFBSfromXML(builder, doc.first_node());
		builder.Finish(element);
		ofstream output(output_filename, ios::out | ios::trunc | ios::binary);
		long size = builder.GetSize();
		output.write((const char*) builder.GetBufferPointer(), size);
		output.close();
	}
#endif
    } catch(parse_error & e) {
        std::cout << "Parse error: " << e.what() << std::endl << "At: " << e.where<char>() << std::endl;
    } catch(validation_error & e) {
        std::cout << "Validation error: " << e.what() << std::endl;
    }
  } else { // invoke srcml
	string srcmlCommand = "srcml ";
	srcmlCommand = srcmlCommand + argv[1];
	system(srcmlCommand.c_str());
  }
  return 0;
}

#ifdef FBS_fast
int loadFBS(bool load_only, int argc, char **argv) {
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
	const struct _fast::Element *element = flatbuffers::GetRoot<Element>(data);
	if (!load_only) {
		string xml_filename = tmpnam(NULL);
		remove(xml_filename.c_str());
		xml_filename +=	".xml";
		fstream out(xml_filename, ios::out | ios::trunc);
		out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
		saveXMLfromFBS(out, element);
		out << endl;
		if (argc == 2) {
			string catCommand = "cat ";
			catCommand = catCommand + xml_filename;
			return system(catCommand.c_str());
		}
		argv[1] = (char*) xml_filename.c_str();
		mainRoutine(argc, argv);
		return remove(xml_filename.c_str());
	}
 	return 0;
}
#endif

#ifdef PB_fast
int loadPB(bool load_only, int argc, char **argv) {
	char *input_filename = argv[1];
  // Verify that the version of the library that we linked against is
  // compatible with the version of the headers we compiled against.
  GOOGLE_PROTOBUF_VERIFY_VERSION;
  fast::Element unit;
  {
    fstream input(input_filename, ios::in | ios::binary);
    if (!unit.ParseFromIstream(&input)) {
      cerr << "Failed to parse compilation unit." << endl;
      return -1;
    }
    if (!load_only) {
		string xml_filename = tmpnam(NULL);
		xml_filename +=	".xml";
#if defined(PB_fast) && !defined(FBS_fast)
		fstream out(xml_filename.c_str());
#else
		fstream out(xml_filename, ios::out | ios::trunc);
#endif
		out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
		saveXMLfromPB(out, &unit);
		out << endl;
		if (argc == 2) {
			string catCommand = "cat ";
			catCommand = catCommand + xml_filename;
			return system(catCommand.c_str());
		}
		argv[1] = (char*) xml_filename.c_str();
		mainRoutine(argc, argv);
		return remove(xml_filename.c_str());
    }
  }
  // Optional:  Delete all global objects allocated by libprotobuf.
  google::protobuf::ShutdownProtobufLibrary();
  return 0;
}
#endif

#ifdef FBS_fast
void saveXMLfromFBS(fstream &out, const struct Element *element) {
	string tag;
	string attr;
	string text = "";
	string tail = "";
	if (element->extra()) {
		if (element->kind() == 0) {
			tag = "unit";
			// cout << element->extra()->unit()->language() << endl;
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
			attr = attr + " revision=\"" + element->extra()->unit()->revision()->c_str() + "\"";
			attr = attr + " language=\"" + lang + "\"";
			attr = attr + " filename=\"" + element->extra()->unit()->filename()->c_str() + "\"";
		} else if (element->kind() == 47) {
			tag = "literal";
			string type = EnumNamesLiteralType()[element->extra()->literal()->type()];
			type = type.substr(0, type.length() - 5);
			attr = attr + " type=\"" + type + "\"";
		} else {
			tag = EnumNamesKind()[element->kind()];
		}
	} else {
		tag = EnumNamesKind()[element->kind()];
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
		attr = attr + " xmlns=\"http://www.srcML.org/srcML/src\" xmlns:" + str + "=\"http://www.srcML.org/srcML/" + str + "\"";
		attr = attr + " revision=\"" + element->unit().revision().c_str() + "\"";
		attr = attr + " language=\"" + lang + "\"";
		attr = attr + " filename=\"" + element->unit().filename().c_str() + "\"";
	} else if (element->kind() == fast::Element_Kind_LITERAL) {
		tag = "literal";
		string type = fast::Element_Literal_LiteralType_Name(element->literal().type());
		type = type.substr(0, type.length() - 5);
		attr = attr + " type=\"" + type + "\"";
	} else {
		tag = fast::Element_Kind_Name(element->kind());
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
				if (attr->name() == string("filename"))
					unit->set_filename(attr->value());
				if (attr->name() == string("revision"))
					unit->set_revision(attr->value());
				if (attr->name() == string("language")) {
					fast::Element_Unit_LanguageType lang;
					string lan = attr->value();
					if (lan == string("C++"))
						lan = "CXX";
					if (lan == string("C#"))
						lan = "CSHARP";
					fast::Element_Unit_LanguageType_Parse(lan, &lang);
					unit->set_language(lang);
				}
				if (attr->name() == string("item")) {
					unit->set_item(atoi(attr->value()));
				}
			}
			if (is_literal) {
				if (attr->name() == string("type")) {
					fast::Element_Literal_LiteralType type;
					fast::Element_Literal_LiteralType_Parse(attr->name(), &type);
					literal->set_type(type);
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
		xml_node<> *child = node->first_node();
		if (child != 0 && string(child->name()) == "") { // first text node
			element->set_text(child->value());
		}
		while (child != 0){
			if (string(child->name()) != "") { // not text node
				fast::Element *child_element = savePBfromXML(child);
				element->add_child()->CopyFrom(*child_element);
			}
			child = child->next_sibling();
		}
		if (node->next_sibling() != 0 && string(node->next_sibling()->name()) == "") { // sibling text node
			element->set_tail(node->next_sibling()->value());
		}
	} 
	return element;
}
#endif

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
	int language = -1;
	int item = -1;
	int type = -1;
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
					// cout << lan << endl;
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
		}
		string str = tag;
		transform(str.begin(), str.end(),str.begin(), ::toupper);
		int kind = flatbuffers::LookupEnum(EnumNamesKind(), str.c_str());
		if (kind == -1)
			cerr << "Warning: the following kind is not found " << str << endl;
		auto extra = CreateAnonymous0(builder, 
			CreateUnit(builder, filename, revision, language, item), 
			CreateLiteral(builder, type));
		xml_node<> *child_node = node->first_node();
		if (child_node != 0 && string(child_node->name()) == "") { // first text node
			text = builder.CreateString(string(child_node->value()));
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
			tail = builder.CreateString(string(node->next_sibling()->value()));
		}
		auto element = _fast::CreateElement(builder, kind, text, tail, child, extra);
		return element;
	} 
	return 0;
}
#endif

int loadSrcML(bool load_only, int argc, char **argv) {
	if (load_only && argc != 2 && argc != 3) // we only accept one or two command line arguments
		return 1;
	if (argc == 3) {
		string xml_filename = tmpnam(NULL);
		xml_filename +=	".xml";
		string srcmlCommand = "srcml ";
		srcmlCommand = srcmlCommand + argv[1] + " -o " + xml_filename;
		system(srcmlCommand.c_str());
		// call the command again, using the generated temporary XML file
		argv[1] = (char *)xml_filename.c_str();
		mainRoutine(argc, argv);
		return remove(xml_filename.c_str());
	}
	if (argc == 2) {
		// invoke srcml and print to standard output
		string srcmlCommand = "srcml ";
		srcmlCommand = srcmlCommand + argv[1];
		system(srcmlCommand.c_str());
	}
	return 0;
}

int mainRoutine(int argc, char* argv[]) {
   if (argc < 2) {
	   cerr << "Usage: fast input_file output_file" << endl;
	   return 1;
   }
   bool load_only = strcmp(argv[1], "-c") == 0;
   if (load_only) {
	   argv++;
	   argc--;
   }
   if (argc == 3 && strcmp(argv[1], argv[2])==0) {
	   cerr << "Warning: input and output file name are the same, no change is needed" << endl;
	   return 1;
   }
#ifdef PB_fast
   if (strcmp(argv[1]+strlen(argv[1])-3, ".pb")==0)
	   return loadPB(load_only, argc, argv);
#endif
#ifdef FBS_fast
   if (strcmp(argv[1]+strlen(argv[1])-4, ".fbs")==0)
	   return loadFBS(load_only, argc, argv);
#endif
   if (strcmp(argv[1]+strlen(argv[1])-4, ".xml")==0)
	   return loadXML(load_only, argc, argv);
   return loadSrcML(load_only, argc, argv);
}

int main(int argc, char* argv[]) {
	return mainRoutine(argc, argv);
}
