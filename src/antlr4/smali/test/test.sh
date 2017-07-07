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
	$fast_smali NavigationMenuPresenter\$1.smali > NavigationMenuPresenter\$1.xml
	catout ce8511380ea2edfa9790dbd0d4d7d8885ea039f06d0c62e6f48dfafd8e58521c NavigationMenuPresenter\$1.xml
	$fast_smali BottomSheetBehavior.smali > BottomSheetBehavior.xml
	catout fa2e460cee168acc315c423dbeffe98f8408a7590a892410400987f073402b90 BottomSheetBehavior.xml
	$fast_smali CoordinatorLayout.smali > CoordinatorLayout.xml
	catout 76832725679e1e2ed9bb407df03be3f44e3f10f82362ef7d60cdcb2d384be173 CoordinatorLayout.xml
	$fast_smali RunnerArgs.smali > RunnerArgs.xml
	catout 1bd495bdd84c7b7dfa789e4c3453af1d7ca682e9cf879a22bef2edb551db6d6a RunnerArgs.xml
	$fast_smali ColorUtils.smali > ColorUtils.xml
	catout 22e7a484d797695bfc50da0f20abf3fcd132497d4af0d9a323f8b8fe99de5015 ColorUtils.xml
	$fast_smali SparseArrayCompat.smali > SparseArrayCompat.xml
	catout 8c15ffd5ccfb57d645fd9d541e18658bb8199186a625170cb7c36e68fbda906e SparseArrayCompat.xml
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
