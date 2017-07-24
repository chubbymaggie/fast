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
	return new_element;
}

map<string,vector<string>> id_comment_names;
string current_unit;
bool is_function_name;
bool is_not_function_name;
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
					std::transform(lan.begin(), lan.end(),lan.begin(), ::toupper);
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
		std::transform(str.begin(), str.end(),str.begin(), ::toupper);
		fast::Element_Kind_Parse(str, &kind);
		element->set_kind(kind);
		if (report_id_comment) {
		       	if (kind == fast::Element_Kind_FUNCTION || kind == fast::Element_Kind_VARIABLE) {
				is_function_name = true;
			}
		       	if (kind == fast::Element_Kind_TYPE || 
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
					id_comment_names[current_unit].push_back(text);
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
						id_comment_names[current_unit].push_back(string(begin, str));
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
			if (limit_width && n > width_limit) {
				element = limitPBbyWidth(element, width_limit);
				n = element->child().size();
			}
			max_width = max(max_width, n);
		}
		if (report_id_comment) {
			if (is_unit) {
				char buf[100], buf2[100];
				strcpy(buf, "/tmp/temp.XXXXXXXX"); 
				mkstemp(buf);
				ofstream out(buf, ios::out | ios::trunc);
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
				cout << current_unit << " ";
				ifstream input(buf2, ios::in);
				std::string line;
				while (input) {
				      std::getline(input, line);
				      cout << line << " ";
				}
				input.close();
				cout << endl;
				remove(buf2);
			}
		}
	} 
	return element;
}
