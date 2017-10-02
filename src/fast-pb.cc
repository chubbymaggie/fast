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

inline void replace_all(string* str, const char* oldValue, const char* newValue)  
{  
    string::size_type pos(0);  
  
    while(true){  
        pos=str->find(oldValue,pos);  
        if (pos!=(string::npos))  
        {  
            str->replace(pos,strlen(oldValue),newValue);  
            pos+=2;
        }  
        else  
            break;  
    }  
}  

map<int, fast::Element*> src_map;
map<int, fast::Element*> dst_map;
map<fast::Element*, int> src_imap;
map<fast::Element*, int> dst_imap;
map<int, enum fast::Element_DiffType> src_pb_changes;
map<int, enum fast::Element_DiffType> dst_pb_changes;
map<int, int> pos_pb_changes;
map<int, int> from_to_pb_changes;

void displayPBElementOne(ofstream &out, fast::Element *element) {
	bool changed = false;
	if (element->text() !="") {
		if (src_pb_changes[src_imap[element]] == fast::Element_DiffType_DELETED) {
			out << "${strikethrough}";
			out << "${red}";
			changed = true;
		}
		if (dst_pb_changes[dst_imap[element]] == fast::Element_DiffType_ADDED) {
			out << "${underline}";
			out << "${green}";
			changed = true;
		}
		if (src_pb_changes[src_imap[element]] == fast::Element_DiffType_CHANGED_FROM) {
			out << "${italic}";
			out << "${yellow}";
			changed = true;
		}
		if (dst_pb_changes[dst_imap[element]] == fast::Element_DiffType_CHANGED_TO) {
			out << "${bold}";
			out << "${blue}";
			changed = true;
		}
		string text = element->text();
		replace_all(&text, "\\", "\\\\");
		replace_all(&text, "\"", "\\\"");
		replace_all(&text, "?", "\\?");
		replace_all(&text, "*", "\\*");
		replace_all(&text, "[", "\\[");
		replace_all(&text, "]", "\\]");
		replace_all(&text, ".", "\\.");
		replace_all(&text, "&lt;", "<");
		replace_all(&text, "&gt;", ">");
		replace_all(&text, "&amp;", "&");
		out << text;
		if (changed) {
			out << "${reset}";
		}
	}
	for (int i=0; i<element->child().size(); i++) {
		fast::Element *child = element->mutable_child(i);
		displayPBElementOne(out, child);
	}
	string tail = element->tail();
	replace_all(&tail, "\\", "\\\\");
	replace_all(&tail, "\"", "\\\"");
	replace_all(&tail, "?", "\\?");
	replace_all(&tail, "*", "\\*");
	replace_all(&tail, "[", "\\[");
	replace_all(&tail, "]", "\\]");
	replace_all(&tail, ".", "\\.");
	replace_all(&tail, "&lt;", "<");
	replace_all(&tail, "&gt;", ">");
	replace_all(&tail, "&amp;", "&");
	out << tail;
}


void displayPBElement(fast::Element *element) {
	char buf[100];
	strcpy(buf, "/tmp/temp.XXXXXXXX"); 
	mkstemp(buf);
	remove(buf);
	strcat(buf, ".pl");
	ofstream out(buf, ios::out | ios::trunc);
	out << "#!perl" << endl;
	out << "my $dim_magenta=\"\\e[38;5;146m\";" << endl;
	out << "my $reset=\"\\e[0m\";" << endl;
	out << "my $bold=\"\\e[1m\";" << endl;
	out << "my $italic=\"\\e[3m\";" << endl;
	out << "my $underline=\"\\e[4m\";" << endl;
	out << "my $strikethrough=\"\\e[9m\";" << endl;
	out << "my $red=\"\\e[31m\";" << endl;
	out << "my $green=\"\\e[32m\";" << endl;
	out << "my $yellow=\"\\e[33m\";" << endl;
	out << "my $blue=\"\\e[34m\";" << endl;
	out << "my $pink=\"\\e[35m\";" << endl;
	out << "print \"" << endl;
	displayPBElementOne(out, element);
	out << "\";" << endl;
	out.close();
	string cmd = "perl ";
	cmd = cmd + buf;
	(void) system(cmd.c_str());
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
bool skip_element(fast::Element *element, string condition) {
      vector<string> tests = csv_split(condition, '|');
      bool found = false;
      for (string t: tests) {
      	      vector<string> key_value = csv_split(t, '=');
	      string key=key_value[0];
	      string value=key_value[1];
	      std::transform(key.begin(), key.end(),key.begin(), ::toupper);
	      // cout << key << "=" << value << endl;
	      int n = element->child().size();
 	      for (int i=0; i<n; i++) {
		fast::Element *child = element->mutable_child(i);
		if (fast::Element_Kind_Name(child->kind()) == key) {
			if (child->text() == value) {
				found = true;
				break;
			}
		}
	      }
      }
      if (found) {
	cout << element->text();
      } 
      return ! found;
}

std::string rtrim(const std::string &s)   
{  
    if (s.empty()) return s;
    string s1 = s;
    // s.erase(0,s.find_first_not_of(" "));  
    // cout << s << endl;
    s1.erase(s1.find_last_not_of(" ") + 1);  
    return s1;  
} 

fast::Element* normaliseASTonePass(fast::Element* element, string op, string parent_name, string child_name, string key_name) {
	fast::Element* new_element = new fast::Element();
	new_element->set_kind(element->kind());
	new_element->set_text(element->text());
	new_element->set_tail(element->tail());
	std::transform(parent_name.begin(), parent_name.end(),parent_name.begin(), ::toupper);
	std::transform(child_name.begin(), child_name.end(),child_name.begin(), ::toupper);
	if (op == "order") {
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
				fast::Element *normalised_child = normaliseASTonePass(child, op, parent_name, child_name, key_name);
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
	} else if (op == "skip") {
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
				fast::Element *normalised_child = normaliseASTonePass(child, op, parent_name, child_name, key_name);
				selected_children.push_back(normalised_child);
				// if the previous element is a comment, it should be sorted together
				if (i > 0 && has_comment) {
					// cout << "selected comment " << endl;
					selected_comments[normalised_child] = element->mutable_child(i-1);
				}
			}
		}
		int m = 0;
		for (int i=0; i<n; i++) {
			fast::Element *child = element->mutable_child(i);
			if (fast::Element_Kind_Name(child->kind()) == child_name) {
				// cout << child_name << endl;
				fast::Element *new_child = new_element->add_child();
				fast::Element *sc = selected_children[m];
				if (!skip_element(sc, key_name)) {
					if (selected_comments[sc]!=NULL) { 
						new_child->CopyFrom(*selected_comments[sc]);
						new_child = new_element->add_child();
					}
					new_child->CopyFrom(*sc);
				}
				m++;
			} else if (i < n-1 && fast::Element_Kind_Name(element->mutable_child(i+1)->kind()) == child_name
					&& !skip_element(element->mutable_child(i+1), key_name)
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
	} else if (op == "replace") {
		if (fast::Element_Kind_Name(element->kind()) == parent_name) {
			int n = element->child().size();
			vector<fast::Element*> selected_children;
			for (int i=0; i<n; i++) {
				fast::Element *child = element->mutable_child(i);
				if (fast::Element_Kind_Name(child->kind()) == child_name) {
					fast::Element *normalised_child = normaliseASTonePass(child, op, parent_name, child_name, key_name);
					selected_children.push_back(normalised_child);
				}
			}
			int m = 0;
			for (int i=0; i<n; i++) {
				fast::Element *child = element->mutable_child(i);
				if (fast::Element_Kind_Name(child->kind()) == child_name) {
					fast::Element *new_child = new_element->add_child();
					fast::Element *sc = new fast::Element();
					sc->set_kind(fast::Element_Kind_NOP); 
					sc->set_text(key_name);
					new_child->CopyFrom(*sc);
					m++;
				} else if (i < n-1 && fast::Element_Kind_Name(element->mutable_child(i+1)->kind()) == child_name) {
					fast::Element *new_child = new_element->add_child();
					new_child->CopyFrom(*child);
					new_child->set_tail(rtrim(new_child->tail())); // remove the trailing spaces in the tail of the previous element
				} else {
					fast::Element *new_child = new_element->add_child();
					new_child->CopyFrom(*child);
				}
			}
			if (element->has_unit()) {
				new_element->mutable_unit()->CopyFrom(element->unit());
			}
			new_element->CopyFrom(*new_element);
		} else {
			new_element->CopyFrom(*element);
		}
	}
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
		if (args.size()>4 && ((args[0] == "order" && args[3] == "by")
				 || (args[0] == "replace" && args[3] == "by") 
				 || (args[0] == "skip" && args[3] == "unless")))
		{
			string parent_name = args[1];
			if (parent_name == "unit") 
				parent_name = "unit_kind";
			element->CopyFrom(*normaliseASTonePass(element, args[0], parent_name, args[2], args[4]));
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
					if (value == string("nil")) // for objective-c
						value = "null";
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
		string str = tag;
		fast::Element_Kind kind = fast::Element_Kind_UNIT_KIND;
		std::transform(str.begin(), str.end(),str.begin(), ::toupper);
		fast::Element_Kind_Parse(str, &kind);
		if (kind != -1) {
			element->set_kind(kind);
			if (report_id_comment) {
				if (kind == fast::Element_Kind_TYPE || kind == fast::Element_Kind_PACKAGE || kind == fast::Element_Kind_IMPORT) {
					ignore_name = true; // opening tag
				}
			}
		} else {
			fast::SmaliKind smali_kind;
			fast::SmaliKind_Parse(str, &smali_kind);
			element->set_smali_kind(smali_kind);
		}
		xml_node<> *child = node->first_node();
		if (child != 0 && string(child->name()) == "") { // first text node
			element->set_text(child->value());
			if (element->type_case()==fast::Element::kKind && (report_id_comment && ((kind == fast::Element_Kind_NAME && !ignore_name)|| 
				kind == fast::Element_Kind_COMMENT))) { // NAME or COMMENT
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
		if (element->type_case()==fast::Element::kKind && report_id_comment) {
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
				(void) system(cmd.c_str());
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
	assert(strcmp(input_filename, "")!=0);
	// Verify that the version of the library that we linked against is
	// compatible with the version of the headers we compiled against.
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data data;
	ifstream input(input_filename, ios::in | ios::binary);
    	if (!data.ParseFromIstream(&input)) {
	      cerr << "Failed to parse compilation unit: " << input_filename<< endl;
	}
	input.close();
	return data;
}

void saveXMLfromPB(fstream & out, fast::Element *element);
void srcSliceToCsv(const srcSlice& handler, const char* output_file);


static int id = 1;
void createIdMapOne(fast::Element* element, map<int, fast::Element*> * amap,
		map<fast::Element*, int> *imap) {
	for (int i=0; i<element->child().size(); i++) {
		fast::Element* child = element->mutable_child(i);
		createIdMapOne(child, amap, imap);
	}
	(*amap)[id] = element;
	(*imap)[element] = id;
	id++;
}
void createIdMap(fast::Element* element, map<int, fast::Element*> * amap,
	map<fast::Element*, int> *imap) {
	id = 1;
	amap->clear();
	imap->clear();
	createIdMapOne(element, amap, imap);
}

bool HIGHLIGHT_CHANGE = false;

void mark_empty(fast::Element *e) {
	e->set_text("#DELETED#");
	for (int i=0; i< e->child().size(); i++) {
		mark_empty(e->mutable_child(i));
	}
	e->set_tail("");
	if (HIGHLIGHT_CHANGE)
		e->set_change(fast::Element_DiffType_DELETED);
	else
		e->set_change(fast::Element_DiffType_MATCHED);
}

map<int, int> mappings;

fast::Element *insertChildAt(fast::Element *e, int pos) {
	fast::Element *child = e->add_child();
	if (pos >= e->child().size())
		return child;
	fast::Element *tmp = e->mutable_child(pos);
	for (int i= e->child().size() - 1; i > pos; i--) {
		fast::Element *c = e->mutable_child(i);
		c->CopyFrom(*e->mutable_child(i-1));
	}
	tmp->CopyFrom(*child); // now tmp should be an empty node
	return tmp;
}

void mergePBpatchOne(fast::Element *a) {
	// cout << "merging  " << src_imap[a] << endl;
	bool changed = false;
	if (src_pb_changes[src_imap[a]] == fast::Element_DiffType_DELETED) {
		// cout << "deleted " << src_imap[a] << endl;
		mark_empty(a);
		if (HIGHLIGHT_CHANGE)
			a->set_change(fast::Element_DiffType_DELETED);
		else
			a->set_change(fast::Element_DiffType_MATCHED);
	}
	if (src_pb_changes[src_imap[a]] == fast::Element_DiffType_CHANGED_FROM) {
		// cout << "changed from " << src_imap[a] << endl;
		mark_empty(a);
		if (HIGHLIGHT_CHANGE)
			a->set_change(fast::Element_DiffType_CHANGED_FROM);
		else
			a->set_change(fast::Element_DiffType_MATCHED);
		int dst = from_to_pb_changes[src_imap[a]]; // src_parent
		int pos = pos_pb_changes[src_imap[a]];
		if (pos == -1) {
		    fast::Element *b = dst_map[dst];
		    a->set_text(b->text()); // update
		} else {
		    fast::Element *b = dst_map[dst];
		    if (b!=NULL)
			if (pos < b->child().size()) {
				int src = mappings[dst];
				if (src > 0) {
					// cout << src << endl;
					fast::Element * src_element = src_map[src];
					if (src_element != NULL) {
						fast::Element *pos_element = insertChildAt(src_element, pos);
						pos_element->CopyFrom(*(b->mutable_child(pos)));
						pos_element->set_change(fast::Element_DiffType_CHANGED_TO);
					}
				}
			}
		}
	}
	for (int i=0; i<a->child().size(); i++) {
		fast::Element *child = a->mutable_child(i);
		mergePBpatchOne(child);
	}
}

void mergePBpatch(fast::Element *a) {
	mergePBpatchOne(a);
}

void mergePBNewLineOne(fast::Element *added_element) {
	if (HIGHLIGHT_CHANGE) return;
	if (added_element->text() == "\n") {
		added_element->set_text("$\n$");
	}
	if (added_element->tail() == "\n") {
		added_element->set_tail("$\n$");
	}
	for (int i=0; i<added_element->child().size(); i++) {
		fast::Element *child = added_element->mutable_child(i);
		mergePBNewLineOne(child);
	}
}

void mergePBNewLine(fast::Element *added) {
	mergePBNewLineOne(added);
}

void mergePBaddedOne(fast::Element *to_add, fast::Element *b) {
	for (int i=0; i<b->child().size(); i++) {
		fast::Element *child = b->mutable_child(i);
		mergePBaddedOne(to_add, child);
		if (dst_pb_changes[dst_imap[child]] == fast::Element_DiffType_ADDED) {
			int src = mappings[dst_imap[b]]; // src_parent
			if (src>0) {
				fast::Element *added_element = src_map[src]->add_child();
				added_element->CopyFrom(*child);	
				if (HIGHLIGHT_CHANGE)
					added_element->set_change(fast::Element_DiffType_ADDED);
				else
					added_element->set_change(fast::Element_DiffType_CHANGED_FROM);
				mergePBNewLine(added_element);
			}
		}
	}
}

void mergePBadded(fast::Element *to_add, fast::Element *b) {
	mergePBaddedOne(to_add, b);
}

void savePBelement(const char *filename, fast::Element* element) {
	fstream output(filename, ios::out | ios::trunc | ios::binary);
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data *data = new fast::Data();
	data->set_allocated_element(element);
	data->SerializeToOstream(&output);
	// google::protobuf::ShutdownProtobufLibrary();
	output.close();
}

int loadPB(int load_only, int argc, char **argv) {
	if (!check_exists(argv[1])) return 1;
	char *input_filename = argv[1];
	assert(strcmp(input_filename, "")!=0);
	fast::Data data = readData(input_filename);
    if (data.has_element() && !load_only && !mySlice && !delta) {
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
	out.close();
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
	const char *output_name = (string(argv[argc - 1]) + ".xml").c_str();
	fstream out(output_name, ios::out | ios::trunc);
	out << "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" << endl;
	saveXMLfromPB(out, &unit);
	out.close();
	argv[2] = strdup((string(argv[argc - 1]) + ".pb").c_str());
	argv[1] = strdup(output_name);
	argc = 3;
	(void) mainRoutine(argc, argv);
    } else if (data.has_delta() && delta && argc == 2) {
	string src_filename = data.delta().src();
	string dst_filename = data.delta().dst();
	fast::Data src_data = readData(src_filename.c_str());
	fast::Data dst_data = readData(dst_filename.c_str());
	createIdMap(src_data.mutable_element(), &src_map, &src_imap);
	createIdMap(dst_data.mutable_element(), &dst_map, &dst_imap);
	for (int i=0; i<data.mutable_delta()->diff().size(); i++) {
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_MATCH) {
			fast::Delta_Diff_Match *diff = data.mutable_delta()->mutable_diff(i)->mutable_match();
			if (diff!=NULL)
				mappings[diff->dst()] = diff->src();
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_DEL) {
			fast::Delta_Diff_Del *diff = data.mutable_delta()->mutable_diff(i)->mutable_del();
			if (diff != NULL)
				src_pb_changes[diff->src()] = fast::Element_DiffType_DELETED;
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_ADD) {
			fast::Delta_Diff_Add *diff = data.mutable_delta()->mutable_diff(i)->mutable_add();
			if (diff!=NULL)
				dst_pb_changes[diff->src()] = fast::Element_DiffType_ADDED;
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_UPDATE) {
			fast::Delta_Diff_Update *diff = data.mutable_delta()->mutable_diff(i)->mutable_update();
			if (diff!=NULL) {
				int src = diff->src();
				int dst = diff->dst();
				src_pb_changes[src] = fast::Element_DiffType_CHANGED_FROM;
				dst_pb_changes[dst] = fast::Element_DiffType_CHANGED_TO;
				from_to_pb_changes[src] = dst;
				pos_pb_changes[src] = -1; // no need to move
			}
		}
		if (data.mutable_delta()->mutable_diff(i)->type() == fast::Delta_Diff_DeltaType_MOVE) {
			fast::Delta_Diff_Move *diff = data.mutable_delta()->mutable_diff(i)->mutable_move();
			if (diff!=NULL) {
				int src = diff->src();
				int dst = diff->dst();
				src_pb_changes[src] = fast::Element_DiffType_CHANGED_FROM;
				dst_pb_changes[dst] = fast::Element_DiffType_CHANGED_TO;
				from_to_pb_changes[src] = dst;
				pos_pb_changes[src] = diff->position();
			}
		}
	}
	displayPBElement(src_data.mutable_element());
	displayPBElement(dst_data.mutable_element());
	fast::Element* merged = new fast::Element();
	merged->CopyFrom(*src_data.mutable_element());
	createIdMap(merged, &src_map, &src_imap);
	mergePBpatch(merged);
	mergePBadded(merged, dst_data.mutable_element());
	if (merged!=NULL) {
		string output_filename = argv[1];
		output_filename = output_filename + "-patched" + ".pb";
		savePBelement(output_filename.c_str(), merged);
	}
    } else if (data.has_element() && delta && argc == 3) {
	    string src_filename = argv[1];
	    string dst_filename = argv[2];
	    string cmd = "gumtree diff ";
	    cmd += src_filename + " " + dst_filename + "> /dev/null";
	    (void) system(cmd.c_str());
	    // cout << cmd << endl;
	    argc = 2;
	    if (src_filename.find("/") != string::npos) {
		    src_filename = src_filename.substr(src_filename.rfind("/")+1);
	    }
	    if (src_filename.find(".pb") != string::npos) {
		    src_filename = src_filename.substr(0, src_filename.rfind(".pb"));
	    }
	    if (dst_filename.find("/") != string::npos) {
		    dst_filename = dst_filename.substr(dst_filename.rfind("/")+1);
	    }
	    if (dst_filename.find(".pb") != string::npos) {
		    dst_filename = dst_filename.substr(0, dst_filename.rfind(".pb"));
	    }
	    argv[1] = strdup((src_filename + "=" + dst_filename + "-diff.pb").c_str());
	    loadPB(load_only, argc, argv);
    }
  // Optional:  Delete all global objects allocated by libprotobuf.
  // google::protobuf::ShutdownProtobufLibrary();
  return 0;
}

bool keep_element; 
void slicePB(srcSliceHandler& handler, fast::Element *element) {
	string text = "";
	string tail = "";
	int k = element->kind();
	// cout << "k = " << k << endl;
	bool keep_start = true;
	if (k == fast::Element_Kind_UNIT_KIND) {
		struct srcsax_attribute attrs[3];
		attrs[2].value = element->unit().filename().c_str();
		keep_element = true;
		handler.startUnit(NULL, NULL, NULL, 0, NULL, 3, attrs);
		keep_start = keep_element;
	} else {
		struct srcsax_attribute attrs[1];
		attrs[0].value = std::to_string(element->line()).c_str();
		keep_element = true;
		handler.startElement(k, NULL, NULL, 0, NULL, 1, attrs);
		keep_start = keep_element;
	}
	text = element->text();
	if (text!="") {
		handler.charactersUnit(text.c_str(), strlen(text.c_str()));
	}
	for (int i=0; i<element->child().size(); i++)
		slicePB(handler, element->mutable_child(i));
	bool keep_end = true;
	if (k == fast::Element_Kind_UNIT_KIND) {
		handler.endUnit(NULL, NULL, NULL);
	} else {
		handler.endElement(k, NULL, NULL);
		keep_end = keep_element;
	}
	if (keep_start || keep_end) {
		element->set_keep(true);
	}
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
	if (element->type_case() == fast::Element::kKind && element->kind()== fast::Element_Kind_UNIT_KIND) {
		string str = fast::Element_Unit_LanguageType_Name(element->unit().language());
		string lang = str;
		tag = "unit";
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
	} else if (element->type_case() == fast::Element::kKind && element->kind() == fast::Element_Kind_LITERAL) {
		tag = "literal";
		string type = fast::Element_Literal_LiteralType_Name(element->literal().type());
		type = type.substr(0, type.length() - 5);
		attr = attr + " type=\"" + type + "\"";
		if (position && (element->line()!=0 || element->column()!=0))
			attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
	} else if (element->type_case() == fast::Element::kKind) {
		tag = fast::Element_Kind_Name(element->kind());
		if (position && (element->line()!=0 || element->column()!=0))
			attr = attr + " pos:line=\"" + std::to_string(element->line()) + "\"" + " pos:column=\"" + std::to_string(element->column()) + "\"";
	} else if (element->type_case() == fast::Element::kSmaliKind) {
		tag = fast::SmaliKind_Name(element->smali_kind());
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
	// cout << (!slice && !mySlice) << endl;
	if ((!slice && !mySlice) || element->keep()) {
		text = element->text();
		transform(tag.begin(), tag.end(), tag.begin(), ::tolower);
		out << "<" <<  tag <<  attr << ">" << text;
	} 
	for (int i=0; i<element->child().size(); i++) {
		saveXMLfromPB(out, element->mutable_child(i));
	}
	if ((!slice && !mySlice) || element->keep()) {
		tail = element->tail();
		out << "</" << tag << ">" << tail;
	}
}
