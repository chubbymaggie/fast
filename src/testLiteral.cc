#include <iostream>
#include "fast.pb.h"

using namespace std;
int main(int argc, char ** argv) {
	fast::Element_Literal_LiteralType type;
	bool success = fast::Element_Literal_LiteralType_Parse("string_type", &type);
	cout << " string = " << type << " success?" << success << endl;
}
