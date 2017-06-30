/**
 * @file srcSlice.cpp
 *
 * @copyright Copyright (C) 2013-2014  SDML (www.srcML.org)
 *
 * The srcML Toolkit is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * The srcML Toolkit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with the srcML Toolkit; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <srcSliceHandler.hpp>
#include <srcSAXController.hpp>
#include <time.h> 
#include <map>
#include <iostream>
#include <fstream>
#include "fast.pb.h"
using namespace std;

void TestSlice2(const VarMap& mp){
	for(VarMap::const_iterator vmIt = mp.begin(); vmIt != mp.end(); ++vmIt){
		std::cerr<<"-------------------------"<<std::endl;
		std::cerr<<"Variable: "<<vmIt->first<<std::endl;
		std::cerr<<"Slines: {";
		for(unsigned int sl : vmIt->second.slines){
			std::cerr<<sl<<",";
		}
		std::cerr<<"}"<<std::endl;
		std::cerr<<"dvars: {";
		for(std::string dv : vmIt->second.dvars){
			std::cerr<<dv<<",";
		}
		std::cerr<<"}"<<std::endl;
		std::cerr<<"is aliase for: {";
		for(std::string al : vmIt->second.aliases){
			std::cerr<<al<<",";
		}
		std::cerr<<"}"<<std::endl;
		std::cerr<<"cfuntions: {";
		for(auto cfunc : vmIt->second.cfunctions){
			std::cerr<<cfunc.first<<" "<<cfunc.second<<",";
		}
		std::cerr<<"}"<<std::endl;
		std::cerr<<"-------------------------"<<std::endl;
	}
}
void TestSlice(const FileFunctionVarMap& mp, srcSliceHandler handler){
	for(FileFunctionVarMap::const_iterator ffvmIt = mp.begin(); ffvmIt != mp.end(); ++ffvmIt){
		std::cerr<<"FILE: "<<ffvmIt->first<<std::endl;
        for(FunctionVarMap::const_iterator fvmIt = ffvmIt->second.begin(); fvmIt != ffvmIt->second.end(); ++fvmIt){
			std::cerr<<fvmIt->first<<std::endl;
			//std::cerr<<handler.sysDict->functionTable.find(fvmIt->first)->second<<std::endl; 
			for(VarMap::const_iterator vmIt = fvmIt->second.begin(); vmIt != fvmIt->second.end(); ++vmIt){
				std::cerr<<"-------------------------"<<std::endl;
				std::cerr<<"Variable: "<<vmIt->first<<std::endl;
				std::cerr<<"Slines: {";
				for(unsigned int sl : vmIt->second.slines){
					std::cerr<<sl<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"variables dependant on this one: {";
				for(std::string dv : vmIt->second.dvars){
					std::cerr<<dv<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"is aliase for: {";
				for(std::string al : vmIt->second.aliases){
					std::cerr<<al<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"cfuntions: {";
				for(auto cfunc : vmIt->second.cfunctions){
						std::cerr<<cfunc.first<<" "<<cfunc.second<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"def: {";
				for(auto defv : vmIt->second.def){
					std::cerr<<defv<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"use: {";
				for(auto usev : vmIt->second.use){
					std::cerr<<usev<<",";
				}
				std::cerr<<"}"<<std::endl;
				std::cerr<<"-------------------------"<<std::endl;
			}
		}
	}
}

void srcSliceToCsv(const srcSlice& handler, const char *output_file){
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data *data = new fast::Data();
	fast::Slice *slice = new fast::Slice();
	std::string str;
	for(FileFunctionVarMap::const_iterator ffvmIt = handler.dictionary.ffvMap.begin(); ffvmIt != handler.dictionary.ffvMap.end(); ++ffvmIt){
		//auto fileNameIt = handler.dictionary.fileTable.find(ffvmIt->first);
		//if(fileNameIt != handler.dictionary.fileTable.end())
		fast::Slice_SourceFile *file = slice->add_file();
		if (output_file != NULL) {
			file->set_name(ffvmIt->first);
		}
		for(FunctionVarMap::const_iterator fvmIt = ffvmIt->second.begin(); fvmIt != ffvmIt->second.end(); ++fvmIt){
			//auto functionNameIt = handler.dictionary.functionTable.find();
			fast::Slice_SourceFile_Function *function = file->add_function();
			if (output_file != NULL) {
				function->set_name(fvmIt->first);
			}
			for(VarMap::const_iterator vmIt = fvmIt->second.begin(); vmIt != fvmIt->second.end(); ++vmIt) {
				fast::Slice_SourceFile_Function_Variable *variable = function->add_variable();
				if (output_file != NULL) {
					variable->set_name(vmIt->first);
				}
				str.append(ffvmIt->first).append(",").append(fvmIt->first).append(",").append(vmIt->first);
				str.append(",def{");
				for(unsigned int def : vmIt->second.def){
					fast::Slice_SourceFile_Function_Variable_Position *pos = variable->add_def();
					if (output_file != NULL) {
						pos->set_lineno(def);
					}
					std::stringstream ststrm;
					ststrm<<def;
					str.append(ststrm.str()).append(",");
				}
				if(str.at(str.length()-1) == ',')
					str.erase(str.length()-1);
				str.append("},");
				str.append("use{");
				for(unsigned int use : vmIt->second.use){
					fast::Slice_SourceFile_Function_Variable_Position *pos = variable->add_use();
					if (output_file != NULL) {
						pos->set_lineno(use);
					}
					
				    std::stringstream ststrm;
				    ststrm<<use;
				    str.append(ststrm.str()).append(",");
				}
				if(str.at(str.length()-1) == ',')
				    str.erase(str.length()-1);
				str.append("},");
				str.append("dvars{");
				for(std::string dv : vmIt->second.dvars){
					if (output_file != NULL) {
						variable->add_dvar(dv);
					}
					str.append(dv.append(","));
				}
				if(str.at(str.length()-1) == ',')
					str.erase(str.length()-1);
				str.append("},");
				str.append("pointers{");
				for(std::string al : vmIt->second.aliases){
					if (output_file != NULL) {
						variable->add_alias(al);
					}
					str.append(al.append(","));
				}
				if(str.at(str.length()-1) == ',')
					str.erase(str.length()-1);
				str.append("},");
				str.append("cfuncs{");
				for(auto cfunc : vmIt->second.cfunctions){
					fast::Slice_SourceFile_Function_Variable_FunctionDecl *decl = variable->add_cfunc();
					if (output_file != NULL) {
						decl->set_name(cfunc.first);
						decl->set_lineno(cfunc.second);
					}
					std::stringstream ststrm;
					ststrm<<cfunc.second;
					str.append(cfunc.first).append("{").append(ststrm.str()).append("},");
				}
				if(str.at(str.length()-1) == ',')
					str.erase(str.length()-1);
				str.append("}");
				std::cout<<str<<std::endl;
				str.clear();
			}
		}
	}
	if (output_file != NULL && data != NULL) {
		ofstream output(output_file, ios::out | ios::trunc | ios::binary);
		data->set_allocated_slice(slice);
		data->SerializeToOstream(&output);
  		google::protobuf::ShutdownProtobufLibrary();
		output.close();
	}
}
/**
 * main
 * @param argc number of arguments
 * @param argv the provided arguments (array of C strings)
 * 
 * Invoke srcSAX handler to count element occurences and print out the resulting element counts.
 */
/*
  Type Resolution tool
  Def Use Tool as separate thing (same as type res?)
  methods
  statement #
  Consider output to srcML
  */
int slice_main(int argc, char * argv[]) {

  if(argc < 2) {

    std::cerr << "Useage: srcSlice input_file.xml\n";
    exit(1);

  }
  clock_t t;
  t = clock();
  srcSlice sslice;
  sslice.ReadArchiveFile(argv[1]);
  t = clock() - t;
  std::cerr<<"Time is: "<<((float)t)/CLOCKS_PER_SEC<<std::endl;
  //std::string filename = handler.sysDict->find("stack.cpp.xml");
  //handler.ComputeInterprocedural("SlicerTestSample.cpp");
  //TestSlice(handler.sysDict-> handler);
  //TestSlice2(handler.sysDict->globalMap);
  srcSliceToCsv(sslice, NULL);
  return 0;
}
