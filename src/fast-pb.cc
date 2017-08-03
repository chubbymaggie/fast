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

string key_name;
int my_ordering(fast::Element *e1, fast::Element *e2) {
	string k1, k2;
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
		std::sort(selected_children.begin(), selected_children.end(), my_ordering);
	}
	int m = 0;
	for (int i=0; i<n; i++) {
		fast::Element *child = element->mutable_child(i);
		if (fast::Element_Kind_Name(child->kind()) == child_name) {
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

