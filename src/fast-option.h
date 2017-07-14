#ifndef FAST_OPTION_H
#define FAST_OPTION_H
#include <string>
using namespace std;
extern int decode; 
extern int encode; 
extern int json;
extern int jq;
extern int position; 
extern int slice; 
extern int mySlice; 
extern int load_only; 
extern int git; 
extern int pb2xml;
extern int process;
extern int slicediff;
extern bool delta; 
extern string head;
extern string jq_query;
extern void usage(); 
extern bool check_exists(const std::string& name);
extern int mainRoutine(int argc, char* argv[]);
extern int smaliMainRoutine(int argc, char** argv);
extern int pbMainRoutine(int argc, const char* argv[]);
extern int processMainRoutine(int argc, char**argv);
extern int sliceDiffMainRoutine(int argc, char**argv);
extern int loadXML(int load_only, int argc, char**argv);
extern string preprocess_git(string head, bool delta);
#endif
