#!/bin/sh
testEquality()
{
	    assertEquals 1 1
}

testPartyLikeItIs1999()
{
    year=`date '+%Y'`
    assertNotEquals "It's not 1999 :-(" \
        '1999' "${year}"
}
testJava() 
{
	cat > Hello.java <<EOF

public class Hello {
	public static void main(String args[]) {
		System.out.println("Hello, world!");
	}
}
EOF
}
testCC() 
{
	cat > example.cc <<EOF
int f(int x) {
	  int result = (x / 42);
	    return result;
}
EOF
}

. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
