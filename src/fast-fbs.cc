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
#include "flatbuffers/flatbuffers.h"
#include "flatbuffers/idl.h"
#include "flatbuffers/util.h"
#include "fast_generated.h"
#include <sys/stat.h> 
#include <srcSliceHandler.hpp>
#include <srcSlice.hpp>
#include <array>
using namespace std;
using namespace rapidxml;

using namespace _fast;
using namespace _fast::_Element;
using namespace _fast::_Element::_Literal;
using namespace _fast::_Element::_Unit;

#include "fast-option.h"

void saveXMLfromFBS(ofstream &out, const struct Element *element);

int mainRoutine(int argc, char* argv[]);
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

bool is_srcml = true;
bool is_smali_cpp = false;
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

static int pos = 0;
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
