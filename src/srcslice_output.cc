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

void srcSliceToCsv(const srcSlice& handler, const char *output_file){
	GOOGLE_PROTOBUF_VERIFY_VERSION;
	fast::Data *data = new fast::Data();
	fast::Slices *slices = new fast::Slices();
	fast::Slices_Slice *slice = slices->add_slice();
	std::string str;
	for(FileFunctionVarMap::const_iterator ffvmIt = handler.dictionary.ffvMap.begin(); ffvmIt != handler.dictionary.ffvMap.end(); ++ffvmIt){
		//auto fileNameIt = handler.dictionary.fileTable.find(ffvmIt->first);
		//if(fileNameIt != handler.dictionary.fileTable.end())
		fast::Slices_Slice_SourceFile *file = slice->add_file();
		if (output_file != NULL) {
			file->set_name(ffvmIt->first);
		}
		for(FunctionVarMap::const_iterator fvmIt = ffvmIt->second.begin(); fvmIt != ffvmIt->second.end(); ++fvmIt){
			//auto functionNameIt = handler.dictionary.functionTable.find();
			fast::Slices_Slice_SourceFile_Function *function = file->add_function();
			if (output_file != NULL) {
				function->set_name(fvmIt->first);
			}
			for(VarMap::const_iterator vmIt = fvmIt->second.begin(); vmIt != fvmIt->second.end(); ++vmIt) {
				fast::Slices_Slice_SourceFile_Function_Variable *variable = function->add_variable();
				if (output_file != NULL) {
					variable->set_name(vmIt->first);
				}
				str.append(ffvmIt->first).append(",").append(fvmIt->first).append(",").append(vmIt->first);
				str.append(",def{");
				for(unsigned int def : vmIt->second.def){
					fast::Slices_Slice_SourceFile_Function_Variable_Position *pos = variable->add_defn();
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
					fast::Slices_Slice_SourceFile_Function_Variable_Position *pos = variable->add_use();
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
					fast::Slices_Slice_SourceFile_Function_Variable_FunctionDecl *decl = variable->add_cfunc();
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
		data->set_allocated_slices(slices);
		data->SerializeToOstream(&output);
  		// google::protobuf::ShutdownProtobufLibrary();
		output.close();
	}
}
