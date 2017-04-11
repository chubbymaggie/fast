#!/bin/sh
#testEquality()
#{
#	    assertEquals 1 1
#}
#
#testPartyLikeItIs1999()
#{
#    year=`date '+%Y'`
#    assertNotEquals "It's not 1999 :-(" \
#        '1999' "${year}"
#}
testJava() 
{
	cat > Hello.java <<EOF

public class Hello {
	public static void main(String args[]) {
		System.out.println("Hello, world!");
	}
}
EOF
	cat > Hello.xml-expected <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<unit xmlns="http://www.srcML.org/srcML/src" revision="0.9.5" language="Java" filename="Hello.java">
<class><specifier>public</specifier> class <name>Hello</name> <block>{
	<function><specifier>public</specifier> <specifier>static</specifier> <type><name>void</name></type> <name>main</name><parameter_list>(<parameter><decl><type><name>String</name></type> <name><name>args</name><index>[]</index></name></decl></parameter>)</parameter_list> <block>{
		<expr_stmt><expr><call><name><name>System</name><operator>.</operator><name>out</name><operator>.</operator><name>println</name></name><argument_list>(<argument><expr><literal type="string">"Hello, world!"</literal></expr></argument>)</argument_list></call></expr>;</expr_stmt>
	}</block></function>
}</block></class>
</unit>
EOF
../fast Hello.java Hello.xml
d=$(diff Hello.xml Hello.xml-expected)
assertSame "$d" ""
rm -f Hello.java
rm -f Hello.xml
rm -f Hello.xml-expected
}
testCC() 
{
	cat > example.cc <<EOF
int f(int x) {
	  int result = (x / 42);
	    return result;
}
EOF
	cat > example.xml-expected <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<unit xmlns="http://www.srcML.org/srcML/src" xmlns:cpp="http://www.srcML.org/srcML/cpp" revision="0.9.5" language="C++" filename="example.cc"><function><type><name>int</name></type> <name>f</name><parameter_list>(<parameter><decl><type><name>int</name></type> <name>x</name></decl></parameter>)</parameter_list> <block>{
	  <decl_stmt><decl><type><name>int</name></type> <name>result</name> <init>= <expr><operator>(</operator><name>x</name> <operator>/</operator> <literal type="number">42</literal><operator>)</operator></expr></init></decl>;</decl_stmt>
	    <return>return <expr><name>result</name></expr>;</return>
}</block></function>
</unit>
EOF
../fast example.cc example.xml
d=$(diff example.xml example.xml-expected)
assertSame "$d" ""
rm -f example.cc
rm -f example.xml
rm -f example.xml-expected
}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

if [ ! -f ../fast ]; then
	cd .. 
	make -f Makefile.in
	cd -
fi

. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
