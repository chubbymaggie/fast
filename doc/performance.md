# Performance

## Parsing
`fast` speeds up parsing by at least 10x for Protobuf implementation and 20x for FlatBuffers implementation, 
according the following significant benchmarks. 

![Benchmarks 1. Most popular projects in 5 programming languages](https://github.com/f-ast/fast/raw/master/doc/benchmarks/benchmarks1.png "The projects are selected from those with the most stars on GitHub.") 
![Benchmarks 2. Bug related commits in evolving artefacts in Java](https://github.com/f-ast/fast/raw/master/doc/benchmarks/benchmarks2.png "The projects are selected from academic studies on the bug localization problems.")

## Slicing
`fast` speeds up forward slicing by at least 2x according the benchmarks of srcSlice. 
![Benchmarks 3. Program slicing](https://github.com/f-ast/fast/raw/master/doc/benchmarks/slicing.png "The projects are selected from previous performance evaluation
of the scalable srcSlice tool.")

## Diffing
`fast` speeds up diffing by 11~25x according a benchmarks of two code pairs taken respectively from Hello and Antlr4 repositories. 
![Benchmarks 4. Diffing](https://github.com/f-ast/fast/raw/master/doc/benchmarks/diffing.png "Grammar is a source file from the Antlr4 project")

## Benchmarks

### C
* [Linux Kernel](https://github.com/torvalds/linux)
* [ed-1.2](http://ftp.vim.org/ftp/gnu/ed/ed-1.2.tar.gz) [ed-1.6](https://ftp.osuosl.org/pub/blfs/conglomeration/ed/ed-1.6.tar.gz)
* [which-2.20](https://ftp.gnu.org/gnu/which/which-2.20.tar.gz)
* [wdiff-0.5](https://ftp.gnu.org/gnu/wdiff/wdiff-0.5.tar.gz)
* [barcode-0.98](https://ftp.gnu.org/gnu/barcode/barcode-0.98.tar.gz)
* [acct-6.5](https://ftp.gnu.org/gnu/acct/acct-6.5.tar.gz)
* [make-3.82](https://ftp.gnu.org/gnu/make/make-3.82.tar.gz)
* [libkate-0.3.8](http://ftp.osuosl.org/pub/xiph/releases/kate/libkate-0.3.8.tar.gz)
* [enscript-1.4.0](https://ftp.gnu.org/gnu/enscript/enscript-1.4.0.tar.gz) [enscript-1.6.5](https://ftp.gnu.org/gnu/enscript/enscript-1.6.5.tar.gz) [enscript-1.6.5.1](https://ftp.gnu.org/gnu/enscript/enscript-1.6.5.1.tar.gz) [enscript-1.6.5.2](https://ftp.gnu.org/gnu/enscript/enscript-1.6.5.2.tar.gz)
* [a2ps-4.10.4](https://ftp.gnu.org/gnu/a2ps/a2ps-4.10.4.tar.gz)
* [findutils-4.4.2](https://ftp.gnu.org/gnu/findutils/findutils-4.4.2.tar.gz)
* [radius-1.0](https://ftp.gnu.org/gnu/radius/radius-1.0.tar.gz)
* [dico-2.2](https://ftp.gnu.org/gnu/dico/dico-2.2.tar.gz)
* [cvs-1.12.10](https://ftp.gnu.org/gnu/non-gnu/cvs/source/feature/1.12.10/cvs-1.12.10.tar.gz)
* [Clanlib-4.0.0](https://github.com/sphair/ClanLib/archive/v4.0.0.tar.gz)
* [HippoDraw-1.21.3](http://pkgs.fedoraproject.org/repo/pkgs/HippoDraw/HippoDraw-1.21.3.tar.gz/d4b427b7469af5728951eab8c502074d/HippoDraw-1.21.3.tar.gz)
* [Quantlib-0.9.7](http://downloads.sourceforge.net/quantlib/QuantLib-0.9.7.tar.gz)

### C++
* [Tensorflow](https://github.com/tensorflow/tensorflow)

### Java
* [Apache Tomcat](https://github.com/apache/tomcat)
* [Eclipse AspectJ](https://git.eclipse.org/gitroot/aspectj/org.aspectj)
* [Eclipse BIRT](https://github.com/eclipse/birt)
* [Eclipse JDT](https://git.eclipse.org/r/p/jdt/eclipse.jdt.ui)
* [Eclipse Platform](https://git.eclipse.org/r/p/platform/eclipse.platform.ui)
* [Eclipse SWT](https://git.eclipse.org/r/p/platform/eclipse.platform.swt)
* [RxJava](https://github.com/ReactiveX/RxJava)

### C#
* [Corefx](https://github.com/dotnet/corefx)

### Objective C
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
