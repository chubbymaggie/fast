#include <string.h>
#include <string>
#include <iostream>
#include <fstream>
#include <ostream>
#include <locale>
#include <unistd.h>
#include <map>
#include "fast-option.h"
using namespace std;


int loadSrcML(int load_only, int argc, char **argv) {
	if (load_only && argc != 2 && argc != 3 && argc != 4) 
		// we only accept maximally three command line arguments
		return 1;
	if (git) { 
		head = preprocess_git(head, delta);
	}
	string srcmlCommand = "srcml";
	bool input_is_xml = false;
	bool output_is_xml = false;
	bool output_is_pb = false;
	string xml_filename;
	bool is_smali = false;
	char *my_argv[4];
	for (int i = 1; i < (argc == 2? 2 : argc - 1); i++) { // process the inputs, and reserve the last argument as output
		if (!check_exists(argv[i])) {
			cerr << "file or folder " << argv[i] << "does not exist!" << endl;
			return 1;
		}
		input_is_xml = strcmp(argv[i]+strlen(argv[i])-4, ".xml")==0;
		if (input_is_xml) {
			xml_filename = argv[i];
		}
		is_smali = strcmp(argv[i]+strlen(argv[i])-6, ".smali")==0;
		if (is_smali) {
			my_argv[0] = argv[0];
			my_argv[1] = argv[i];
		}
		if (git && i==1 && head != "") {
			chdir(head.c_str());
		}
		srcmlCommand = srcmlCommand + " " + argv[i];
	}
	// cout << "====" << argv[argc - 1] << endl;
	if (position)
		srcmlCommand = srcmlCommand + " --position";
	bool is_tmp = false;
	if (!input_is_xml) { // input is not yet xml, first convert it into xml using srcml
		output_is_xml = argc == 2 || strcmp(argv[argc-1]+strlen(argv[argc-1])-4, ".xml")==0;
		output_is_pb = argc > 2 && strcmp(argv[argc-1]+strlen(argv[argc-1])-3, ".pb")==0;
		if (!slice && output_is_xml) {
			if (argc == 2)
				xml_filename = "stdout://-";
			else
				xml_filename = argv[argc - 1];
		} else {
			char buf[100];
			strcpy(buf, "/tmp/temp.XXXXXXXX"); 
			mkstemp(buf);
			remove(buf);
			xml_filename = buf;
			xml_filename +=	".xml";
			is_tmp = true;
		}
		if (is_smali && argc == 2) {
			return smaliMainRoutine(2, my_argv);
		} else if (is_smali) {
			my_argv[2] = argv[argc-1];
			return smaliMainRoutine(3, my_argv);
		}
		if (!process && !slicediff) {
			srcmlCommand = srcmlCommand + " -o " + xml_filename;
			// cout << srcmlCommand << endl;
			(void) system(srcmlCommand.c_str());
		}
	}
	if (slice) {
		string sliceCommand = "srcSlice ";
		sliceCommand = sliceCommand + xml_filename + " > " + xml_filename + ".slice";
		(void) system(sliceCommand.c_str());
		string catCommand = "cat ";
		catCommand = catCommand + xml_filename + ".slice";
		(void) system(catCommand.c_str());
		remove((xml_filename + ".slice").c_str());
	} else if (!input_is_xml && !output_is_xml && !process && !slicediff) { // target is not xml
		argv[argc-2] = strdup(xml_filename.c_str());
		loadXML(load_only, 3, argv + argc-3);
	} else if (argc == 3 && process && output_is_pb) {
		my_argv[0] = argv[0];
		my_argv[1] = argv[1];
		my_argv[2] = argv[2];
		(void) processMainRoutine(3, my_argv);
	} else if (argc == 4 && slicediff && output_is_pb) {
		my_argv[0] = argv[0];
		my_argv[1] = argv[1];
		my_argv[2] = argv[2];
		my_argv[3] = argv[3];
		(void) sliceDiffMainRoutine(4, my_argv);
	} else {
		if (argc == 3 && input_is_xml) {
			srcmlCommand = srcmlCommand + " -o " + argv[2];
		}
		(void) system(srcmlCommand.c_str());
	}
	if (is_tmp)
		remove(xml_filename.c_str());
	return 0;
}
