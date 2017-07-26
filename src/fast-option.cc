#include <string.h>
#include <string>
#include <iostream>
#include <fstream>
#include <ostream>
#include <locale>
#include <unistd.h>
#include <map>
#include "ver.h"
using namespace std;

int decode = 0; 
int encode = 0; 
int json = 0;
int jq = 0;
int position = 0; 
int slice = 0; 
int mySlice = 0; 
int load_only = 0; 
int git = 0; 
int pb2xml = 0;
int process = 0;
int slicediff = 0;
bool delta = false; 
string head = "HEAD";
string jq_query = ".";
int report_max_width = 0;
int report_id_comment = 0;
int include_comment = 0;
int limit_width = 0;
int width_limit = 0;

int find_pattern = 0;
string find_filter;

void saveTxtFromPB(char *input_file);
void saveTxtFromPB(char *input_file, char *output_file);
void savePBfromTxt(char *input_file);
void savePBfromTxt(char *input_file, char *output_file);
int loadPB(int load_only, int argc, char **argv);
int loadFBS(int load_only, int argc, char **argv);
int loadXML(int load_only, int argc, char**argv);
int loadSrcML(int load_only, int argc, char **argv);

void usage() {
    cerr << "Usage: fast [-cdDef:g:hijJ:lLpsSvwW:x] input_file output_file"  << endl
	 << "-c\tLoad only" << endl
	 << "-d\tDecode protobuf into text format" << endl
	 << "-D \tDelta slicing" << endl
	 << "-e\tEncode text format into protobuf" << endl
	 << "-f <ext>\tFind certain files by the extension `ext` when saving protobuf" << endl
	 << "-g <hash>\tCheckout Git <hash> for slicing" << endl
	 << "-h\tPrint this help message" << endl
	 << "-i\treport the identifier names and comment for bug localisation" << endl
	 << "-j\tuse JSON instead of textual format to encode/decode" << endl
	 << "-J <jq>\tuse jq query to process the decoded JSON content, turn on -d -j options" << endl
	 << "-l\tProcess log pairs from cross-language repositories" << endl
	 << "-L\tDifferentiate on the slices" << endl
	 << "-p\tPreserve the position (line, column) numbers" << endl
	 << "-s\tSlice programs on the srcML format" << endl
	 << "-S\tSlice programs on the binary format" << endl
	 << "-v\tTell version number" << endl
	 << "-w\tReport the maximum number of nodes (i.e. width) of the AST" << endl
	 << "-W <width>\tLimit the number of children to 'width' by a transformation" << endl
	 << "-x\tDump any protobuf text format to XML" << endl;
}

int mainRoutine(int argc, char* argv[]) {
   if (argc < 2) {
	   usage();
	   return 1;
   }
   if (argc == 3 && strcmp(argv[1], argv[2])==0) {
	   cerr << "Warning: input and output file name are the same, no change is needed" << endl;
	   return 1;
   }
#ifdef PB_fast
   if (strcmp(argv[1]+strlen(argv[1])-3, ".pb")==0 && !slicediff) {
	  if (decode && argc == 2) {
	    saveTxtFromPB(argv[1]);
	    return 0;
	  } else if (decode && argc == 3) {
	    saveTxtFromPB(argv[1], argv[2]);
	    return 0;
	  }
	  return loadPB(load_only, argc, argv);
   }
   if (strcmp(argv[1]+strlen(argv[1])-4, ".txt")==0) {
	  if (encode && argc == 3) {
	    savePBfromTxt(argv[1], argv[2]);
	  } else if (encode && argc == 2) {
	    savePBfromTxt(argv[1]);
	  }
	  return 0;
   }
#endif
#ifdef FBS_fast
   if (strcmp(argv[1]+strlen(argv[1])-4, ".fbs")==0)
	   return loadFBS(load_only, argc, argv);
#endif
   if (strcmp(argv[1]+strlen(argv[1])-4, ".xml")==0)
	   return loadXML(load_only, argc, argv);
   return loadSrcML(load_only, argc, argv);
}

int main(int argc, char* argv[]) {
  int c;

  opterr = 0;
  decode = 0;
  position = 0;
  slice = 0;
  mySlice = 0;
  encode = 0;
  while ((c = getopt (argc, argv, "cdDef:g:hijJ:lLpsSvwW:x")) != -1)
    switch (c) {
      case 'h':
	    usage();
	    return 0;
      case 'v':
	    cerr << "fast " << __FAST_VERSION__ << " commit id: " << __FAST_HASH__ << " with local changes id: " << __FAST_WORK__ << endl
		 << "built with " << __VERSION__ << " on " << __DATE__ << " at " << __TIME__ << endl;
	    return 0;
      case 'D':
	    delta = true;
	    break;
      case 'f':
	    find_pattern = 1;
	    find_filter = optarg;
	    break;
      case 'i':
	    report_id_comment = 1;
	    break;
      case 'g':
	    git = 1;
	    head = optarg;
	    break;
      case 'e':
	    encode = 1;
	    break;
      case 'S':
	    mySlice = 1;
	    position = 1; // slicing requires positions
	    break;
      case 's':
	    slice = 1;
	    position = 1; // slicing requires positions
	    break;
      case 'p':
	    position = 1;
	    break;
      case 'd':
	    decode = 1;
	    break;
      case 'c':
            load_only = 1;
	    include_comment = 1;
            break;
      case 'x':
	    pb2xml = 1;
	    decode = 1;
	    break;
      case 'l':
	    process = 1;
	    break;
      case 'L':
	    slicediff = 1;
	    break;
      case 'j':
	    json = 1;
	    break;
      case 'J':
	    jq = 1;
	    json = 1;
	    decode = 1;
	    jq_query = optarg;
	    break;
      case 'w':
            report_max_width = 1;
            break;
      case 'W':
            limit_width = 1;
            report_max_width = 1;
	    width_limit = atoi(optarg);
            break;
      case '?':
	if (isprint (optopt))
          fprintf (stderr, "Unknown option `-%c'.\n", optopt);
        else
          fprintf (stderr,
                   "Unknown option character `\\x%x'.\n",
                   optopt);
        return 1;
      default:
        abort ();
    }
    return mainRoutine(argc - optind + 1, argv + optind - 1);
}
