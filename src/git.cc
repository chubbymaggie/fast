#include <iostream>
#include <stdio.h>
#include <string>
#include <array>
#include <stdlib.h>
#include <vector>
#include <sstream>
#include <memory>
using namespace std;
string exec(string command)
{
	std::array<char, 128> buffer;
	string result;
	std::shared_ptr<FILE> pipe(popen(command.c_str(), "r"), pclose);
	if (!pipe) throw runtime_error("popen() failed!");
	while (!feof(pipe.get())) {
	    if (fgets(buffer.data(), 128, pipe.get()) != NULL)
		result += buffer.data();
	}
	return result;
}

/**
 * checkout from the current git repository
 */
string preprocess_git(string head, bool delta)
{
	string command = "git rev-list " + head + " --";
	string hashes = exec(command);
	stringstream ss(hashes);
	string line;
	vector<string> vec;
	while (getline(ss, line, '\n')) 
		vec.push_back(line);
	string file_a = "";
	string file_b = "";
	if (vec.size()>=1) {
		file_b = vec[0];
	} else {
		file_b = head;
	}
	if (vec.size()==1) {
		delta = false;
	}
	// find previously checked out folder 
	for (int i=1; i<vec.size(); i++) {
		string v = vec[i];
		FILE *f = fopen(v.c_str(), "r");
		if (f!=NULL) {
			file_a = v;
			fclose(f);
			break;
		}
	}
	if (file_a == "" || !delta) {
		string command = "mkdir -p " + file_b;
		system(command.c_str());
		command = "git --work-tree=" + file_b + " checkout -f " + file_b + " -- .";
		system(command.c_str());
		return file_b;
	} else {
		command = "git dl log " + file_a + ".." + file_b;
		string diff_records = exec(command);
		cout << diff_records << endl;
		return "";
	}
}

