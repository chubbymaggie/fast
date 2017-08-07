#include <string.h>
#include <string>
#include <iostream>
#include <fstream>
#include <ostream>
#include <locale>
#include <unistd.h>
#include <map>
#include <vector>
#include <algorithm>
#include "fast.pb.h" 
#include "rapidxml.hpp"
#include "rapidxml_utils.hpp"
#include "rapidxml_print.hpp"
#include "fast-option.h"
#include <stdlib.h>
#include <srcSliceHandler.hpp>
#include <srcSlice.hpp>

using namespace std;
using namespace rapidxml;
/**
 * Limit the width of an AST by introducing intermediate tree nodes of NOP kind
 */
fast::Element* limitPBbyWidth(fast::Element* element, int width) {
	if (width < 2) {
		cerr << "Please enter a positive width larger than 1" << endl;
	}
	assert ( width >= 2);
	fast::Element* new_element = new fast::Element();
	int n = element->child().size();
	if (n <= width)
		return element;
	// cout << n << endl;
	// m is the number of children of the new element
	/* if (n < width) { // padding n - width elements
		int m = width;
		for (int i=0; i<m; i++) {
			if (i >= n) { // padding
				fast::Element *child = new_element->add_child();
				child->set_kind(fast::Element_Kind_NOP); 
			} else {
				fast::Element *new_child = limitPBbyWidth(element->mutable_child(i), width);
				fast::Element *child = new_element->add_child();
				child->CopyFrom(*new_child);
			}
		}
		// now the number of child should be exactly `width`
	} else { // splitting
	*/
	int m = min(width, (n + width - 1) /width);
	for (int i=0; i<m; i++) {
		fast::Element *candidate_child = new fast::Element();
		candidate_child->set_kind(fast::Element_Kind_NOP); 
		int M = (n + m - 1) / m;
		for (int j = 0; j < M; j++) {
			int I = i * M + j;
			if (I < n) {
				fast::Element *child = candidate_child->add_child();
				// recursively call all the child to limit their width
				fast::Element *new_child = limitPBbyWidth(element->mutable_child(I), width);
				child->CopyFrom(*new_child);
			}
		}
		// now candidate_child has M child, which may also need to be recursively limited
		fast::Element *new_c = limitPBbyWidth(candidate_child, width);
		fast::Element *c = new_element->add_child();
		c->CopyFrom(*new_c);
	}
	// }
	if (element->has_unit()) {
		new_element->mutable_unit()->CopyFrom(element->unit());
	}
	return new_element;
}

vector<string> normalise_instructions;

string toStringFromPBElement(fast::Element* element) {
	string str = element->text();
	int n = element->child().size();
	for (int i=0; i<n; i++) {
		string s = toStringFromPBElement(element->mutable_child(i));
		str += s;
	}
	str += element->tail();
	return str;
}

string key_name;
int my_ordering(fast::Element *e1, fast::Element *e2) {
	string k1, k2;
	if (key_name == "TEXT()") {
		k1 = toStringFromPBElement(e1);
		k2 = toStringFromPBElement(e2);
		// cout << "k1 = " << k1 << " k2 = " << k2 << endl;
	} else {
		for (int j=0; j<e1->child().size(); j++) {
			const fast::Element *key = e1->mutable_child(j);
			if (fast::Element_Kind_Name(key->kind()) == key_name) {
				k1 = key->text();
				break;
			}
		}
		for (int j=0; j<e2->child().size(); j++) {
			const fast::Element *key = e2->mutable_child(j);
			if (fast::Element_Kind_Name(key->kind()) == key_name) {
				k2 = key->text();
				break;
			}
		}
	}
	// cout << "k1 = " << k1 << " k2 = " << k2 << endl;
	if (k1 < k2) 
		return 1;
	return 0;
}

fast::Element* normaliseASTonePass(fast::Element* element, string parent_name, string child_name, string key_name) {
	fast::Element* new_element = new fast::Element();
	new_element->set_kind(element->kind());
	new_element->set_text(element->text());
	new_element->set_tail(element->tail());
	std::transform(parent_name.begin(), parent_name.end(),parent_name.begin(), ::toupper);
	std::transform(child_name.begin(), child_name.end(),child_name.begin(), ::toupper);
	std::transform(key_name.begin(), key_name.end(),key_name.begin(), ::toupper);
	int n = element->child().size();
	vector<fast::Element*> selected_children;
	map<fast::Element*, fast::Element*> selected_comments;
	for (int i=0; i<n; i++) {
		fast::Element *child = element->mutable_child(i);
		if (fast::Element_Kind_Name(child->kind()) == child_name) {
			bool has_comment = false;
			if (i > 0) {
				has_comment = fast::Element_Kind_Name(element->mutable_child(i-1)->kind()) == "COMMENT";
			}
			fast::Element *normalised_child = normaliseASTonePass(child, parent_name, child_name, key_name);
			selected_children.push_back(normalised_child);
			// if the previous element is a comment, it should be sorted together
			if (i > 0 && has_comment) {
				// cout << "selected comment " << endl;
				selected_comments[normalised_child] = element->mutable_child(i-1);
			}
		}
	}
	if (fast::Element_Kind_Name(element->kind()) == parent_name) {
		::key_name = key_name;
		// cout << key_name << endl;
		std::sort(selected_children.begin(), selected_children.end(), my_ordering);
	}
	int m = 0;
	for (int i=0; i<n; i++) {
		fast::Element *child = element->mutable_child(i);
		if (fast::Element_Kind_Name(child->kind()) == child_name) {
			// cout << child_name << endl;
			fast::Element *new_child = new_element->add_child();
			fast::Element *sc = selected_children[m];
			if (selected_comments[sc]!=NULL) {
				// first insert the comment
				// cout << "insert the comment " << endl;
				new_child->CopyFrom(*selected_comments[sc]);
				new_child = new_element->add_child();
			}
			new_child->CopyFrom(*sc);
			m++;
		} else if (i < n-1 && fast::Element_Kind_Name(element->mutable_child(i+1)->kind()) == child_name
				&& fast::Element_Kind_Name(child->kind()) == "COMMENT") {
			; // skip the comment
		} else {
			fast::Element *new_child = new_element->add_child();
			new_child->CopyFrom(*child);
		}
	}
	if (element->has_unit()) {
		new_element->mutable_unit()->CopyFrom(element->unit());
	}
	new_element->CopyFrom(*new_element);
	return new_element;
}
/**
 * Normalise the AST according to `normalise_list`
 */
fast::Element* normaliseAST(fast::Element* element) {
	if (normalise_instructions.size() == 0) {
		ifstream input(normalise_list, ios::in);
		string line;
		while (input) {
		      std::getline(input, line);
		      if (line!="") {
			      normalise_instructions.push_back(line);
		      }
		} 
		input.close();
	}
	for (string instruction: normalise_instructions) {
		vector<string> args;
		string str = instruction;
		size_t i;
		do {
			i = str.find(" ");
			string token = str;
			if (i!=std::string::npos) {
				token = str.substr(0, i);
				str = str.substr(i+1);
			} else
				str = "";
			args.push_back(token);
		} while (str!="");
		if (args.size()>4 && args[0] == "order" && args[3] == "by") 
		{
			string parent_name = args[1];
			if (parent_name == "unit") 
				parent_name = "unit_kind";
			element->CopyFrom(*normaliseASTonePass(element, parent_name, args[2], args[4]));
		}
	}
	return element;
}

map<string,vector<string>> id_comment_names;
string current_unit;
bool ignore_name = false;
int max_width = 0;

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
					string filename = attr->value();
					if (find_pattern && find_filter != "") {
					   if (filename.find("." + find_filter)==std::string::npos) {
						// cout << "ignoring " << filename << endl;
						return NULL; // ignore the files that does not end with the find_filter
					   }
					}
					unit->set_filename(filename);
					if (report_id_comment) {
						current_unit = filename;
					}
				}
				if (attr->name() == string("revision"))
					unit->set_revision(attr->value());
				if (attr->name() == string("language")) {
					fast::Element_Unit_LanguageType lang;
					string lan = attr->value();
					std::transform(lan.begin(), lan.end(),lan.begin(), ::toupper);
					if (lan == string("C++"))
						lan = "CXX";
					if (lan == string("C#"))
						lan = "CSHARP";
					if (lan == string("OBJECTIVE-C"))
						lan = "OBJECTIVE_C";
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
		std::transform(str.begin(), str.end(),str.begin(), ::toupper);
		fast::Element_Kind_Parse(str, &kind);
		element->set_kind(kind);
		if (report_id_comment) {
		       	if (kind == fast::Element_Kind_TYPE || kind == fast::Element_Kind_PACKAGE || kind == fast::Element_Kind_IMPORT) {
				ignore_name = true; // opening tag
			}
		}
		xml_node<> *child = node->first_node();
		if (child != 0 && string(child->name()) == "") { // first text node
			element->set_text(child->value());
			if (report_id_comment && ((kind == fast::Element_Kind_NAME && !ignore_name)|| 
				kind == fast::Element_Kind_COMMENT)) { // NAME or COMMENT
				string text = child->value();
				if (kind == fast::Element_Kind_NAME) { // && is_function_name && !ignore_name) {
					id_comment_names[current_unit].push_back(text);
				} 
				if (kind == fast::Element_Kind_COMMENT && include_comment) {
				    const char *str = text.c_str();
				    do {
					const char *begin = str;
					while( (*str <= 'Z' && *str >= 'A') || 
					       (*str <= 'z' && *str >= 'a') || 
					       (*str <= '9' && *str >= '0') || 
					       (*str == '_' || *str == '-'))
					    str++;
					if (begin < str)
						id_comment_names[current_unit].push_back(string(begin, str));
				    } while (0 != *str++);
				}
			}
		}
		int n = 0;
		while (child != 0){
			if (string(child->name()) != "") { // not text node
				fast::Element *child_element = savePBfromXML(child);
				if (child_element!=NULL)
					element->add_child()->CopyFrom(*child_element);
			}
			child = child->next_sibling();
			n++;
		}
		if (node->next_sibling() != 0 && string(node->next_sibling()->name()) == "") { // sibling text node
			element->set_tail(node->next_sibling()->value());
		}
		if (normalise) {
			element = normaliseAST(element);
		}
		if (report_max_width) {
			if (limit_width && n > width_limit) {
				element = limitPBbyWidth(element, width_limit);
				n = element->child().size();
			}
			max_width = max(max_width, n);
		}
		if (report_id_comment) {
		       	if (kind == fast::Element_Kind_TYPE || kind == fast::Element_Kind_PACKAGE || kind == fast::Element_Kind_IMPORT) {
				ignore_name = false; // closing tag
			}
			if (is_unit && element->unit().filename() == current_unit) {
				char buf[100], buf2[100];
				strcpy(buf, "/tmp/temp.XXXXXXXX"); 
				mkstemp(buf);
				ofstream out(buf, ios::out | ios::trunc);
				string base_name;
				if (current_unit.find("/")!=std::string::npos) {
					base_name = current_unit.substr(current_unit.rfind("/")+1);
				} else
					base_name = current_unit;
				if (base_name.find(".") != std::string::npos) {
					base_name = base_name.substr(0, base_name.rfind("."));
				}
				out << base_name << endl;
				for (string name: id_comment_names[current_unit]) {
					out << name << endl;
				}
				out.close();
				strcpy(buf2, "/tmp/temp.XXXXXXXX"); 
				mkstemp(buf2);
				string cmd = "java -cp /usr/local/lib:/usr/local/lib/intt.jar Example ";
				cmd = cmd + buf + " > " + buf2;
				system(cmd.c_str());
				remove(buf);
				cout << base_name << ";";
				ifstream input(buf2, ios::in);
				std::string line;
				while (input) {
				      std::getline(input, line);
				      cout << " " << line;
				}
				input.close();
				cout << endl;
				remove(buf2);
			}
		}
	} 
	return element;
}

/**
 * read bug record
 */
fast::Bugs* savePBfromBugXML(xml_node<> *node)
{
	fast::Bugs *bugs = new fast::Bugs();
	fast::Bugs::Bug *bug;
	string tag = node->name();
	for (xml_attribute<> *attr = node->first_attribute(); attr; attr = attr->next_attribute())
	{
		if (attr->name() == string("repository")) {
			string repository = attr->value();
			bugs->set_repository(repository);
		}
	}
	int n = 0;
	xml_node<> *child = node->first_node();
	while (child != 0){
		if (string(child->name()) != "") { // not text node
			fast::Bugs_Bug *bug = bugs->add_bug();
			bug->set_id(child->first_attribute("id")->value()); // cout << bug->id() << endl;
			bug->set_opendate(child->first_attribute("opendate")->value()); // cout << bug->opendate() << endl;
			xml_node<> *info_node = child->first_node()->next_sibling(); // buginformation
			fast::Bugs_Bug_Info *info = bug->mutable_buginfo();  
			info->set_summary(info_node->first_node()->next_sibling()->value()); 
			info->set_description(info_node->first_node()->next_sibling()->next_sibling()->next_sibling()->value()); 
			info_node = info_node->next_sibling()->next_sibling(); // fixed_files
			xml_node<> *file = info_node->first_node()->next_sibling(); // file
			while (file) {
				bug->add_fixed_file(file->value());
				file = file->next_sibling()->next_sibling();
			}
		}
		child = child->next_sibling();
		n++;
	}
	return bugs;
}

std::vector<std::string> csv_split(std::string source, char delimeter) {
    std::vector<std::string> ret;
    std::string word = "";
    int start = 0;

    bool inQuote = false;
    for(int i=0; i<source.size(); ++i){
        if(inQuote == false && source[i] == '"'){
            inQuote = true;
            continue;
        }
        if(inQuote == true && source[i] == '"'){
            if(source.size() > i && source[i+1] == '"'){
                ++i;
            } else {
                inQuote = false;
                continue;
            }
        }

        if(inQuote == false && source[i] == delimeter){
            ret.push_back(word);
            word = "";
        } else {
            word += source[i];
        }
    }
    ret.push_back(word);

    return ret;
}

fast::Bugs* savePBfromBugCSV(const char *input_filename)
{
	fast::Bugs *bugs = new fast::Bugs();
	ifstream input(input_filename, ios::in);
	std::string line;
        std::getline(input, line); // skip the first header line
	int n = 0;
	while (input) {
	      std::getline(input, line);
	      if (line != "") {
		      vector<string> fields = csv_split(line, ',');
		      fast::Bugs_Bug *bug = bugs->add_bug();
		      bug->set_id(fields[1]); // cout << bug->id() << endl;
		      bug->set_opendate(fields[4]);  // cout << bug->opendate() << endl;
		      fast::Bugs_Bug_Info *info = bug->mutable_buginfo();  
		      info->set_summary(fields[2]); // cout << info->summary() << endl;
		      info->set_description(fields[3]); 
		      for (int i=9; i<fields.size(); i++) {
			bug->add_fixed_file(fields[i]); 
		      }
		      n++;
	      }
	}
	input.close();
	// cout << n << endl;
	string input_file = input_filename;
	string repository = input_file.substr(0, input_file.rfind(".csv"));
	bugs->set_repository(repository);
	return bugs;
}

void slicePB(srcSliceHandler& handler, fast::Element *element);

fast::Data readData(const char *input_filename) {
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

void saveXMLfromPB(fstream & out, fast::Element *element);
void srcSliceToCsv(const srcSlice& handler, const char* output_file);

map<int, fast::Element*> src_map;
map<int, fast::Element*> dst_map;

static int id = 1;
void createIdMapOne(fast::Element* element, map<int, fast::Element*> *map) {
	for (int i=0; i<element->child().size(); i++) {
		fast::Element* child = element->mutable_child(i);
		createIdMapOne(child, map);
	}
	(*map)[id] = element;
	id++;
}
void createIdMap(fast::Element* element, map<int, fast::Element*> *map) {
	id = 1;
	map->clear();
	createIdMapOne(element, map);
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
    } else if (data.has_delta() && delta) {
	string src_filename = data.delta().src();
	string dst_filename = data.delta().dst();
	fast::Data src_data = readData(src_filename.c_str());
	fast::Data dst_data = readData(dst_filename.c_str());
	createIdMap(src_data.mutable_element(), &src_map);
	createIdMap(dst_data.mutable_element(), &dst_map);
	map<int, int> mappings;
	for (int i=0; i<data.mutable_delta()->diff().size(); i++) {
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_MATCH) {
			fast::Delta_Diff_Match *diff = data.mutable_delta()->mutable_diff(i)->mutable_match();
			mappings[diff->src()] = diff->dst();
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_DEL) {
			fast::Delta_Diff_Del *diff = data.mutable_delta()->mutable_diff(i)->mutable_del();
			// cout << "DEL " << diff->src() << endl;
			fast::Element *to_delete = src_map[diff->src()];
			if (to_delete!=NULL)
				to_delete->set_change(fast::Element_DiffType_DELETED);
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_ADD) {
			fast::Delta_Diff_Add *diff = data.mutable_delta()->mutable_diff(i)->mutable_add();
			// int dst = mappings[diff->src()];
			int dst = diff->src();
			int src_parent = mappings[diff->dst()];
			// cout << "==== " << diff->src() << endl;
			fast::Element *parent = src_map[src_parent];
			if (parent!=NULL) {
				fast::Element *new_child = parent->add_child();
				if (dst_map[dst]!=NULL) {
					new_child->CopyFrom(*dst_map[dst]);
					new_child->set_change(fast::Element_DiffType_ADDED);
				}
			}
			// cout << "ADD " << diff->src() << " " << diff->dst() << " " << diff->position() << endl;
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_UPDATE) {
			fast::Delta_Diff_Update *diff = data.mutable_delta()->mutable_diff(i)->mutable_update();
			int src = diff->src();
			int dst = diff->dst();
			fast::Element *src_element = src_map[src];
			fast::Element *dst_element = dst_map[dst];
			src_element->set_change(fast::Element_DiffType_CHANGED_FROM);
			dst_element->set_change(fast::Element_DiffType_CHANGED_TO);
			if (src_element!=NULL && dst_element!=NULL) {
				fast::Element *new_child = src_element->add_child();
				new_child->CopyFrom(*dst_element);
			}
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_MOVE) {
			fast::Delta_Diff_Move *diff = data.mutable_delta()->mutable_diff(i)->mutable_move();
			int src = diff->src();
			int dst = diff->dst();
			int src_parent = mappings[dst];
			int pos = diff->position();
			fast::Element *src_element = src_map[src];
			fast::Element *src_parent_element = src_map[src_parent]->mutable_child(pos);
			src_element->set_change(fast::Element_DiffType_CHANGED_FROM);
			if (src_element!=NULL && src_parent_element!=NULL) {
				fast::Element *new_child = src_parent_element->add_child();
				new_child->CopyFrom(*src_element);
				new_child->set_change(fast::Element_DiffType_CHANGED_TO);
			}
		}
	}
	if (argc == 2) {
		cout << toStringFromPBElement(src_data.mutable_element()) << endl;
	} else if (argc > 2) {
		fstream output(argv[2], ios::out | ios::trunc | ios::binary);
		fast::Data *data = new fast::Data();
		data->set_allocated_element(src_data.mutable_element());
		data->SerializeToOstream(&output);
		google::protobuf::ShutdownProtobufLibrary();
		output.close();
	}
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
#if 0
	if (pb2xml && output_file !=NULL ) {
		const char *my_argv[] = {
			"fast", output_file
		};
		(void) pbMainRoutine(2, my_argv);
	}
#endif
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
	if (element->change() == fast::Element_DiffType_ADDED) {
		attr = attr + " change=\"+\""; 
	} else if (element->change() == fast::Element_DiffType_DELETED) { 
		attr = attr + " change=\"-\""; 
	} else if (element->change() == fast::Element_DiffType_CHANGED_FROM) { 
		attr = attr + " change=\"-+\"";
	} else if (element->change() == fast::Element_DiffType_CHANGED_TO) { 
		attr = attr + " change=\"+-\"";
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
