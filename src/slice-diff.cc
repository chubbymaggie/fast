#include <iostream>
#include <fstream>
#include <set>
#include <algorithm>
#include "fast.pb.h"
using namespace std;

fast::Data readData(const char *input_filename);

set<int> get_defns(const fast::Slices_Slice_SourceFile_Function_Variable *variable, string name) {
	set<int> defns;
	for (int i=0; i< variable->defn_size(); i++) {
		int lineno = variable->defn(i).lineno();
		if (lineno!=0)
			defns.insert(lineno); 
	}
	return defns;
}

set<int> get_uses(const fast::Slices_Slice_SourceFile_Function_Variable *variable, string name) {
	set<int> uses;
	for (int i=0; i< variable->use_size(); i++) {
		int lineno = variable->use(i).lineno();
		if (lineno!=0)
			uses.insert(lineno); 
	}
	return uses;
}


set<string> get_variables(const fast::Slices_Slice_SourceFile_Function *function, string name) {
	set<string> variables;
	for (int i=0; i< function->variable_size(); i++) {
		string name = function->variable(i).name();
		if (name!="")
			variables.insert(name); 
	}
	return variables;
}

set<string> get_functions(const fast::Slices_Slice_SourceFile *file, string name) {
	set<string> functions;
	for (int i=0; i< file->function_size(); i++) {
		string name = file->function(i).name();
		if (name!="")
			functions.insert(name); 
	}
	return functions;
}

const fast::Slices_Slice_SourceFile_Function_Variable* find_variable(const fast::Slices_Slice_SourceFile_Function *function, const string name)
{
	for (int i=0; i<function->variable_size(); i++) {
		if (function->variable(i).name() == name) {
			return &(function->variable(i));
		}
	}
	return NULL;
}

const fast::Slices_Slice_SourceFile_Function* find_function(const fast::Slices_Slice_SourceFile *file, const string name)
{
	for (int i=0; i<file->function_size(); i++) {
		if (file->function(i).name() == name) {
			return &(file->function(i));
		}
	}
	return NULL;
}


set<string> get_files(const fast::Slices_Slice *slice) {
	set<string> files;
	for (int i=0; i< slice->file_size(); i++) {
		string name = slice->file(i).name();
		if (name!="")
			files.insert(name); 
	}
	return files;
}

const fast::Slices_Slice_SourceFile* find_file(const fast::Slices_Slice *slice, const string name)
{
	for (int i=0; i<slice->file_size(); i++) {
		if (slice->file(i).name() == name) {
			return &(slice->file(i));
		}
	}
	return NULL;
}


void merge_positions(fast::Slices_Slice_SourceFile_Function_Variable_Position* fn(void*), 
	fast::Slices_Slice_SourceFile_Function_Variable *c_variable, 
	const set<int> defns_a, const set<int> defns_b)
{
	for (int lineno_b: defns_b) {
		for (int lineno_a: defns_a) {
			fast::Slices_Slice_SourceFile_Function_Variable_Position *defn = fn(c_variable); 
			defn->set_lineno(lineno_b);
			int delta_lineno = lineno_b - lineno_a;
			if (delta_lineno != 0) { // change
				defn->set_delta_lineno(delta_lineno);
				if (delta_lineno > 0)
					defn->set_type(fast::Slices_Slice_ChangeType_ADD);
				else 
					defn->set_type(fast::Slices_Slice_ChangeType_DEL);
			}
		}	
	}
}

fast::Slices_Slice_SourceFile_Function_Variable_Position* add_defn(void* context) {
    return static_cast<fast::Slices_Slice_SourceFile_Function_Variable*>(context)->add_defn();
}

fast::Slices_Slice_SourceFile_Function_Variable_Position* add_use(void* context) {
    return static_cast<fast::Slices_Slice_SourceFile_Function_Variable*>(context)->add_use();
}

void merge_variable(fast::Slices_Slice_SourceFile_Function_Variable *c_variable, const fast::Slices_Slice_SourceFile_Function *a_function, 
		const fast::Slices_Slice_SourceFile_Function *b_function, const string name) {
	cout << "merging variable" + name << endl;
	const fast::Slices_Slice_SourceFile_Function_Variable *a_variable = find_variable(a_function, name);
	const fast::Slices_Slice_SourceFile_Function_Variable *b_variable = find_variable(b_function, name);
	set<int> defns_a = get_defns(a_variable, name);
	set<int> defns_b = get_defns(b_variable, name);
	merge_positions(&add_defn, c_variable, defns_a, defns_b);
	set<int> uses_a = get_uses(a_variable, name);
	set<int> uses_b = get_uses(b_variable, name);
	merge_positions(&add_use, c_variable, uses_a, uses_b);
}

void copy_variable(fast::Slices_Slice_SourceFile_Function_Variable *c_variable, const fast::Slices_Slice_SourceFile_Function *a_function, const string name) {
	const fast::Slices_Slice_SourceFile_Function_Variable *a_variable = find_variable(a_function, name);
	c_variable->CopyFrom(*a_variable);
}

void merge_function(fast::Slices_Slice_SourceFile_Function *c_function, const fast::Slices_Slice_SourceFile *a_file, 
		const fast::Slices_Slice_SourceFile *b_file, const string name) {
	cout << "merging function" + name << endl;
	const fast::Slices_Slice_SourceFile_Function *a_function = find_function(a_file, name);
	const fast::Slices_Slice_SourceFile_Function *b_function = find_function(b_file, name);
	set<string> variables_a = get_variables(a_function, name);
	set<string> variables_b = get_variables(b_function, name);
	set<string> variables_c;
       	set_union(variables_a.begin(), variables_a.end(), variables_b.begin(), variables_b.end(), 
			inserter(variables_c, variables_c.begin()));
	for (string name: variables_c) {
		fast::Slices_Slice_SourceFile_Function_Variable *variable = c_function->add_variable();
		variable->set_name(name);
		bool in_a = variables_a.find(name) != variables_a.end();
		bool in_b = variables_b.find(name) != variables_b.end();
		if (in_a && in_b) {
			merge_variable(variable, a_function, b_function, name); 
			variable->set_type(fast::Slices_Slice_ChangeType_UNCHANGED);
		} else if (in_a) {
			copy_variable(variable, a_function, name); 
			variable->set_type(fast::Slices_Slice_ChangeType_DEL);
		} else if (in_b) {
			copy_variable(variable, b_function, name); 
			variable->set_type(fast::Slices_Slice_ChangeType_ADD);
		}
	}
}

void copy_function(fast::Slices_Slice_SourceFile_Function *c_function, const fast::Slices_Slice_SourceFile *a_file, const string name) {
	const fast::Slices_Slice_SourceFile_Function *a_function = find_function(a_file, name);
	c_function->CopyFrom(*a_function);
}

void merge_file(fast::Slices_Slice_SourceFile *c_file, const fast::Slices_Slice *a_slice, const fast::Slices_Slice *b_slice, const string name) {
	cout << "merging " + name << endl;
	const fast::Slices_Slice_SourceFile *a_file = find_file(a_slice, name);
	const fast::Slices_Slice_SourceFile *b_file = find_file(b_slice, name);
	set<string> functions_a = get_functions(a_file, name);
	set<string> functions_b = get_functions(b_file, name);
	set<string> functions_c;
       	set_union(functions_a.begin(), functions_a.end(), functions_b.begin(), functions_b.end(), 
			inserter(functions_c, functions_c.begin()));
	for (string name: functions_c) {
		fast::Slices_Slice_SourceFile_Function *function = c_file->add_function();
		function->set_name(name);
		bool in_a = functions_a.find(name) != functions_a.end();
		bool in_b = functions_b.find(name) != functions_b.end();
		if (in_a && in_b) {
			merge_function(function, a_file, b_file, name); 
			function->set_type(fast::Slices_Slice_ChangeType_UNCHANGED);
		} else if (in_a) {
			copy_function(function, a_file, name); 
			function->set_type(fast::Slices_Slice_ChangeType_DEL);
		} else if (in_b) {
			copy_function(function, b_file, name); 
			function->set_type(fast::Slices_Slice_ChangeType_ADD);
		}
	}
}


/**
 * copy everything from Slices_Slice_SourceFile named name to target slice
 */
void copy_file(fast::Slices_Slice_SourceFile *c_file, const fast::Slices_Slice *a_slice, const string name) {
	const fast::Slices_Slice_SourceFile *a_file = find_file(a_slice, name);
	c_file->CopyFrom(*a_file);
}

void merge_files(fast::Slices_Slice *c_slice, const fast::Slices_Slice *a_slice, const fast::Slices_Slice *b_slice) {
	set<string> files_a = get_files(a_slice);
	set<string> files_b = get_files(b_slice);
	set<string> files_c;
       	set_union(files_a.begin(), files_a.end(), files_b.begin(), files_b.end(), 
			inserter(files_c, files_c.begin()));
	for (string name: files_c) {
		fast::Slices_Slice_SourceFile *file = c_slice->add_file();
		file->set_name(name);
		bool in_a = files_a.find(name) != files_a.end();
		bool in_b = files_b.find(name) != files_b.end();
		if (in_a && in_b) {
			merge_file(file, a_slice, b_slice, name); 
			file->set_type(fast::Slices_Slice_ChangeType_UNCHANGED);
		} else if (in_a) {
			copy_file(file, a_slice, name); 
			file->set_type(fast::Slices_Slice_ChangeType_DEL);
		} else if (in_b) {
			copy_file(file, b_slice, name); 
			file->set_type(fast::Slices_Slice_ChangeType_ADD);
		}
	}
}

/**
 * Assume that a, b are singleton slices, named after <40-character long hash>/slice.pb
 *
 */
int sliceDiffMainRoutine(int argc, char **argv)
{
	fast::Data A = readData(argv[1]);
	fast::Data B = readData(argv[2]);
	fast::Data *a = &A;
	fast::Data *b = &B;
	assert(a->slices().slice_size() > 0);
	assert(b->slices().slice_size() > 0);
	fast::Data *c = new fast::Data();
	string a_name = argv[1];
	string b_name = argv[2];
	const fast::Slices_Slice * a_slice = & a->slices().slice(0);
	const fast::Slices_Slice * b_slice = & b->slices().slice(0);
	fast::Slices_Slice * c_slice = c->mutable_slices()->add_slice();
	c_slice->set_hash(a_name.substr(0, 40) + ".." + b_name.substr(0,40));
	merge_files(c_slice, a_slice, b_slice);
	ofstream output(argv[3], ios::out | ios::trunc | ios::binary);
	c->SerializeToOstream(&output);
	output.close();
	return 0;
}
