#!/bin/bash

fast_smali=../fast-smali

stdout() {
	hash=$1
	shift
	assertSame $hash $($fast $@ | shasum -a 256 | awk '{print $1}')
} 
export -f stdout

catout() {
	echo $@
	fast=cat stdout $@
}
export -f catout

stderr() {
	hash=$1
	shift
	assertSame $hash $($fast $@ 2>&1 > /dev/null | shasum -a 256 | awk '{print $1}')
} 
export -f stderr

stdouterr() {
	hash=$1
	shift
	assertSame $hash $($fast $@ 2>&1 | shasum -a 256 | awk '{print $1}')
} 
export -f stdouterr

test1() {
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
	$fast_smali DuplicateVirtualMethods.smali > DuplicateVirtualMethods.xml
	catout c127eb3d6322b3f9d38eaead37e56faf6939fe776587924d361a3e1b280c1ee7 DuplicateVirtualMethods.xml
	$fast_smali IntDef.smali > IntDef.xml
	catout 2c82d17ff69209c7eab9122b93d18bd687d553f4a04a6fe0ffc4e11341a7f4e5 IntDef.xml
	$fast_smali ForegroundLinearLayout.smali > ForegroundLinearLayout.xml
	catout d916e5a39cc38372a4e779a8c6c688d4c16c2df67eeb70717f1bbb633fe3fd6b ForegroundLinearLayout.xml
}
#testFinalReport() {
#	lcov --directory .. --capture --output-file ../fast-smali.info
#	lcov --remove ../fast-smali.info '/usr/*' '/Applications/*' '*/smali/*' '*/src/*.pb.*' '*/src/fast_generated.h' > fast-smali.info
#	genhtml fast-smali.info
#}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

rm -f ../*.gcda
#rm -rf ../fast-smali.info index*.html *.png v1/ gcov.css Users usr
#lcov --directory .. --zerocounters
. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
