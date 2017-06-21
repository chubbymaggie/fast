#!/bin/sh
fast=$(which fast)
if [ "$fast" != "/usr/local/bin/fast" ]; then
	if [ ! -f ../fast -o ! -f ../fast_pb ]; then
		cd .. 
		make -f Makefile.in
		cd -
	fi
fi
if [ "$(uname -s)" = "Linux" ]; then
	fast=${fast:=../fast_pb}
else
	fast=${fast:=../fast}
fi

testJava() 
{
	cat > Hello.java <<EOF

public class Hello {
	public static void main(String args[]) {
		System.out.println("Hello, world!");
	}
}
EOF
assertSame a8e15f72dd2a6f880587f388abfd84d34dea74632566fcea8754b4ceca017a1e $(shasum -a 256 Hello.java | awk '{print $1}')
$fast Hello.java Hello.xml
assertSame 1207fa1c163baec58a7934e2ec7aefdd6fe9d0d08f997b168a3bd1b24a7eebf2 $(shasum -a 256 Hello.xml | awk '{print $1}')
$fast Hello.java Hello.pb
$fast Hello.pb Hello.pb.java
assertSame a8e15f72dd2a6f880587f388abfd84d34dea74632566fcea8754b4ceca017a1e $(shasum -a 256 Hello.pb.java | awk '{print $1}')
#rm -f Hello.java
#rm -f Hello.xml
rm -f Hello.xml-expected
rm -f Hello.pb
rm -f Hello.pb.java
}
testCC() 
{
	cat > example.cc <<EOF
int f(int x) {
	  int result = (x / 42);
	    return result;
}
EOF
assertSame 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 $(shasum -a 256 example.cc | awk '{print $1}')
$fast example.cc example.xml
assertSame 2368362bbad04bf0f9d0b9d010de277f1d6932636dc64756bc23a9abc61a784e $(shasum -a 256 example.xml | awk '{print $1}')
#rm -f example.cc
$fast example.xml example.pb
$fast example.pb example.pb.cc
assertSame 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 $(shasum -a 256 example.pb.cc | awk '{print $1}')
#rm -f example.xml
rm -f example.pb
rm -f example.pb.cc
}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
