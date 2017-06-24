#!/bin/sh
fast=$(which fast)
if [ "$fast" != "/usr/local/bin/fast" ]; then
	if [ ! -f ../fast ]; then
		cd .. 
		configure
		make
		make check
		cd -
	fi
fi
fast=${fast:=../fast}

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
$fast -p Hello.java Hello.position.xml
assertSame 765682328876dc31c834ab0ccec0657a094a267ce68b5353a4072b625637fdd6 $(shasum -a 256 Hello.position.xml | awk '{print $1}')
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
$fast example.xml example.pb
$fast example.pb example.pb.cc
assertSame 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 $(shasum -a 256 example.pb.cc | awk '{print $1}')
$fast -p example.cc example.position.xml
assertSame 873145704786c3f0671984705735f8c7415caf274414cf5fbf82be6bc6ba60cf $(shasum -a 256 example.position.xml | awk '{print $1}')
$fast -p example.cc example.position.fbs
assertSame 6eaf262288d187d5e141942b37eb489b242b6da497315252201bb9c856a489d0 $(shasum -a 256 example.position.fbs | awk '{print $1}')
$fast -p example.cc example.position.pb
assertSame 6a2275d92df2eddba37db73b0c83688db91e159af49fb647db4b8c3fd395941c $(shasum -a 256 example.position.pb | awk '{print $1}')
}
testSmali() 
{
	cat > DuplicateVirtualMethods.smali <<EOF
.class public LDuplicateVirtualMethods;
.super Ljava/lang/Object;

.method public alah()V
    .registers 1
    return-void
.end method

.method public blah()V
    return-void
.end method

.method public blah()V
    .registers 1
    return-void
.end method

.method public clah()V
    .registers 1
    return-void
.end method
EOF
	cat > DuplicateVirtualMethods-v2.smali <<EOF
.class public LDuplicateVirtualMethods;
.super Ljava/lang/Object;

.method public alah()V
    return-void
.end method

.method private blahbla()V
    .registers 2

    return-void

.end method

.method public blah()V
    .registers 1
    return-void
.end method

.method public clah()V
    .registers 1
    return-void
.end method
EOF
assertSame 14807015fc8bc8506ca3d02e40a71b5e7f7aa6d57f8c3b6c5db880d51af35c27 $(shasum -a 256 DuplicateVirtualMethods.smali | awk '{print $1}')
assertSame 313fb700c0d562f562209a523e597d8bc6f70688e7fb176ed9da3faf5b8b221a $(shasum -a 256 DuplicateVirtualMethods-v2.smali | awk '{print $1}')
$fast -a DuplicateVirtualMethods.smali DuplicateVirtualMethods.pb
assertSame 0774322701503693f94f62a74d4a86a5aaa54b3272a253d9f974e28f2eb7ed15 $(shasum -a 256 DuplicateVirtualMethods.pb | awk '{print $1}')
$fast -a DuplicateVirtualMethods.pb DuplicateVirtualMethods.xml
assertSame 285a2785bf67b08c4502b58991404e2f0a747869ae3f4ac2eb04368e6b505910 $(shasum -a 256 DuplicateVirtualMethods.xml | awk '{print $1}')
$fast -a DuplicateVirtualMethods.smali DuplicateVirtualMethods-v2.smali DuplicateVirtualMethods-diff.pb
assertSame a01a9748c77d171f55d500ace774801dcb3753f34b99ceb4564225ba97dcd311 $(shasum -a 256 DuplicateVirtualMethods-diff.pb | awk '{print $1}')
}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
