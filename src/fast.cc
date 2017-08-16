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
#include "flatbuffers/flatbuffers.h"
#include "flatbuffers/idl.h"
#include "flatbuffers/util.h"
#include "fast_generated.h"

using namespace std;
using namespace rapidxml;

#include "fast-option.h"

fast::Element* savePBfromXML(xml_node<> *node);
fast::Bugs* savePBfromBugXML(xml_node<> *node);
fast::Bugs* savePBfromBugCSV(const char *input);
flatbuffers::Offset<_fast::Element> saveFBSfromXML(flatbuffers::FlatBufferBuilder & builder, xml_node<> *node);
int loadSrcML(int load_only, int argc, char **argv);

int mainRoutine(int argc, char* argv[]);
int smaliMainRoutine(int argc, char** argv);
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

int loadCSV(int argc, char**argv) {
	if (bug_analysis) {
		fast::Bugs *bugs = savePBfromBugCSV((const char*) argv[1]);
		if (bugs!=NULL) {
			cout << argv[2] << endl;
			fstream output(argv[2], ios::out | ios::trunc | ios::binary);
			fast::Data *data = new fast::Data();
			data->set_allocated_bugs(bugs);
			data->SerializeToOstream(&output);
			google::protobuf::ShutdownProtobufLibrary();
			output.close();
		}
	}
	return 0;
}

void savePB(xml_document<> *doc, string output_filename) {
	fstream output(output_filename.c_str(), ios::out | ios::trunc | ios::binary);
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data *data = new fast::Data();
	if (bug_analysis) {
		fast::Bugs *bugs = savePBfromBugXML(doc->first_node());
		if (bugs!=NULL) {
			data->set_allocated_bugs(bugs);
			data->SerializeToOstream(&output);
			google::protobuf::ShutdownProtobufLibrary();
			output.close();
		}
	} else {
		fast::Element *element = savePBfromXML(doc->first_node());
		if (element!=NULL) {
			data->set_allocated_element(element);
			data->SerializeToOstream(&output);
			google::protobuf::ShutdownProtobufLibrary();
			output.close();
			if (report_max_width) {
				cout << "The maximum width of tree nodes is :" << max_width << endl;
			}
		}
	}
}

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
	if (is_protobuf) {
		savePB(& doc, output_filename);
	}
	if (is_flatbuffers) {
		if (normalise) {
			savePB(& doc, string(output_filename) + ".pb"); 
			string fbsCommand = "fast ";
			fbsCommand = fbsCommand + output_filename + ".pb " + 
				output_filename + ".xml";
			(void) system(fbsCommand.c_str());
			remove((string(output_filename) + ".pb").c_str());
			fbsCommand = "fast ";
			fbsCommand = fbsCommand + output_filename + ".xml " + 
				output_filename;
			(void) system(fbsCommand.c_str());
			remove((string(output_filename) + ".xml").c_str());
			return 0;
		}
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
    } catch(parse_error & e) {
        // std::cout << "Parse error: " << e.what() << std::endl << "At: " << e.where<char>() << std::endl;
    } catch(validation_error & e) {
        std::cout << "Validation error: " << e.what() << std::endl;
    }
  } else { // invoke srcml
    if (normalise) {
	char *my_argv[6];
	// create a pipeline to introduce a temporary protobuf file as intermediary
	char buf[200];
	strcpy(buf, "/tmp/temp.XXXXXXXX"); 
	mkstemp(buf);
	remove(buf);
	strcat(buf, ".pb");
	my_argv[0] = argv[0];
	my_argv[1] = (char *) "-n";
	my_argv[2] = (char *) normalise_list.c_str();
	my_argv[3] = argv[1];
	my_argv[4] = buf;
	(void) main(5, my_argv);
	if (argc == 3) {
		string fastCommand = "fast ";
		fastCommand = fastCommand + buf + " " + argv[2];
		(void) system(fastCommand.c_str());
	} else if (argc == 2) {
		string fastCommand = "fast ";
		fastCommand = fastCommand + buf + " " + buf + ".java";
		(void) system(fastCommand.c_str());
		string catCommand = "cat ";
	        catCommand = catCommand	+ buf + ".java";
 		(void) system(catCommand.c_str());
		remove(buf);
		strcat(buf, ".java");
		remove(buf);
	}
	remove(buf);
    } else {
	    loadSrcML(load_only, argc, argv);
    }
  }
  return 0;
}
