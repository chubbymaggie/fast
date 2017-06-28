#include <iostream>
#include <fstream>
#include <ostream>
#define SEPARATOR "@@"
#include "fast.pb.h"
#include <stdlib.h>
#include <unistd.h>

int n_srcML_invoked = 0;
/** 
 * convert text into a protobuf element
 */
bool srcML(fast::Element *unit, std::string text, std::string ext) {
	char buf[100];
	strcpy(buf, "/tmp/temp.XXXXXX");
	int id = mkstemp(buf);
	close(id);
	remove(buf);
	strcat(buf, ".");
	strcat(buf, ext.c_str());
	std::string src_filename = buf;
	FILE *output = fopen(src_filename.c_str(), "w");
	if (output!=NULL) {
		fprintf(output, "%s", text.c_str());
		fclose(output);
	} else {
		std::cerr << "cannot write to the file " << src_filename << std::endl;
		std::cerr << text << std::endl;
	}
	strcpy(buf, "/tmp/temp.XXXXXX");
	id = mkstemp(buf);
	close(id);
	remove(buf);
	strcat(buf, ".pb");
	std::string pb_filename = buf;
	char cmd[200];
	FILE * src_file  = fopen(src_filename.c_str(), "r");
	if (src_file != NULL) {
		fclose(src_file);
		//sprintf(cmd, "lsof -p %d", getpid()); system(cmd);
		sprintf(cmd, "fast %s %s", src_filename.c_str(), pb_filename.c_str());
		// std::cout << cmd << std::endl;
		n_srcML_invoked++;
		int ret_val = system(cmd);
		if (ret_val == 0) {
			// remove(src_filename.c_str());
			FILE * pb_file  = fopen(pb_filename.c_str(), "r");
			if (pb_file != NULL) {
				fclose(pb_file);
				std::fstream input(pb_filename.c_str(), std::ios::in | std::ios::binary);
				unit->ParseFromIstream(&input);
				input.close();
				unit->mutable_unit()->set_filename(ext + "." + ext);
				remove(pb_filename.c_str());
			}
		} else {
			std::cerr << "Error found" << std::endl;
			return false;
		}
	} else {
		std::cerr << "srcML invoked ... text outputed ... but cannot open " << src_filename << std::endl;
		return false;
	}
	return true;
}

bool process_hunk_xml(fast::Element **old_code, fast::Element **new_code, std::string text, std::string ext) {
        size_t linePos;
	std::string text_old = "";
	std::string text_new = "";
	do {
	    linePos = text.find("\n");
	    if (linePos != std::string::npos) {
		std::string line = text.substr(0, linePos);
		size_t negPos = line.find("-");
		size_t posPos = line.find("+");
		bool is_special = false;
		if (negPos != std::string::npos) {
		    std::string prefix= line.substr(0, negPos);
		    if (prefix == "") {
			    is_special = true;
			    line = line.substr(negPos + 1);
			    text_old += line + "\n";
		    }
		}
		if (posPos != std::string::npos) {
		    std::string prefix= line.substr(0, posPos);
		    if (prefix == "") {
			    is_special = true;
			    line = line.substr(posPos + 1);
			    text_new += line + "\n";
		    }
		}
		if (! is_special && line != "") {
		    // line = line.substr(1);
		    text_old += line + "\n";
		    text_new += line + "\n";
		}
		text = text.substr(linePos + 1);
	    }
	} while (linePos != std::string::npos);
	if (text_old != "") {
		fast::Element *unit = new fast::Element();
		bool success = srcML(unit, text_old, ext);
		if (!success) {
			std::cerr << "Error found in processing the old text" << std::endl;
			return false;
		}
		// ignore the filename field
		if (unit!=NULL)
			unit->mutable_unit()->set_filename("");
		*old_code = unit;
	}
	if (text_new != "") {
		fast::Element *unit = new fast::Element();
		bool success = srcML(unit, text_new, ext);
		if (!success) {
			std::cerr << "Error found in processing the new text" << std::endl;
			return false;
		}
		// ignore the filename field
		if (unit!=NULL)
			unit->mutable_unit()->set_filename("");
		*new_code = unit;
	}
	return true;
}

fast::Pairs_Pair_Diff *set_diff(std::string index, std::string code, std::string ext) {
	fast::Pairs_Pair_Diff *diff = new fast::Pairs_Pair_Diff();
	size_t spacePos = index.find(" ");
	size_t leftCommaPos = index.find(",");
	size_t rightCommaPos = index.rfind(",");
	int left_line = std::atoi(index.substr(0, leftCommaPos).c_str());
	int left_column = std::atoi(index.substr(leftCommaPos+1, spacePos).c_str());
	int right_line = std::atoi(index.substr(spacePos+1, rightCommaPos).c_str());
	int right_column = std::atoi(index.substr(rightCommaPos+1).c_str());
	diff->set_left_line(left_line);
	diff->set_left_column(left_column);
	diff->set_right_line(right_line);
	diff->set_right_column(right_column);

	fast::Element *old_code = NULL;
	fast::Element *new_code = NULL;
	process_hunk_xml(&old_code, &new_code, code, ext);
	diff->set_allocated_old_code(old_code);
	diff->set_allocated_new_code(new_code);

	return diff;
}

void replaceAll( std::string &s, const std::string &search, const std::string &replace ) {
    for( size_t pos = 0; ; pos += replace.length() ) {
        // Locate the substring to replace
        pos = s.find( search, pos );
        if( pos == std::string::npos ) break;
        // Replace by erasing and inserting
        s.erase( pos, search.length() );
        s.insert( pos, replace );
    }
}



int main(int argc, char ** argv) {
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	std::fstream input(argv[1]);
	std::string line;
	fast::Pairs * pairs = new fast::Pairs(); 
	while (!input.eof()) {
		std::getline(input, line);
                size_t linePos0 = line.find(",");
		if (linePos0 != std::string::npos) {
			fast::Pairs_Pair *pair = pairs->add_pair();
			std::string project = line.substr(0,linePos0);
			pair->set_project(project);
			// std::cout << project <<  std::endl;
			size_t linePos1 = line.substr(linePos0+1).find(SEPARATOR);
			std::string line2 = line.substr(linePos0+1).substr(linePos1 + strlen(SEPARATOR) + 1);
			size_t linePos2 = line2.find(SEPARATOR);
			std::string index1 = line2.substr(0, linePos2 - 1);
			std::string code = line2.substr(linePos2 + strlen(SEPARATOR) + 1);
			size_t linePos3 = code.find(SEPARATOR);
			std::string code1 = code.substr(0, linePos3-1);
			replaceAll(code1, "$$", "\n");
			// std::cout << code1 << std::endl;
			fast::Pairs_Pair_Diff *diff1 = set_diff(index1, code1, "java");
			pair->set_allocated_left(diff1);
			// std::cout << "======" << std::endl;

			std::string index = code.substr(linePos3 + strlen(SEPARATOR) + 1);
			size_t linePos4 = index.find(SEPARATOR);
			std::string index2 = index.substr(0, linePos4 - 1);
			std::string code2 = index.substr(linePos4 + 1);
			replaceAll(code2, "$$", "\n");
			size_t lastPos = code2.rfind(",");
			// std::cout << code2 << std::endl;
			fast::Pairs_Pair_Diff *diff2 = set_diff(index2, code2.substr(0, lastPos - 1), "cs");
			pair->set_allocated_right(diff2);
			int type = std::atoi(code2.substr(lastPos+1).c_str());
			if (type == 0) pair->set_type(fast::Pairs_Pair_CloneType_MAYBE);
			if (type == 1) pair->set_type(fast::Pairs_Pair_CloneType_YES);
			if (type == 2) pair->set_type(fast::Pairs_Pair_CloneType_NO);
		}
	}
	fast::Data * data = new fast::Data(); 
	data->set_allocated_pairs(pairs);
	std::fstream output(argv[2], std::ios::out | std::ios::trunc | std::ios::binary);
	data->SerializeToOstream(&output);
	output.close();
	google::protobuf::ShutdownProtobufLibrary();
}
