[![Build Status](https://travis-ci.org/yijunyu/fast.svg?branch=master)](https://travis-ci.org/yijunyu/fast)
[![Coverage Status](https://coveralls.io/repos/github/yijunyu/fast/badge.svg?branch=master)](https://coveralls.io/github/yijunyu/fast?branch=master)

# `fast` -- Flat Abstract Syntax Trees

Abstract syntax trees (ASTs) are hierarchical, recursive structures for
representing source code.  Parsing them typically requires a full traversal of
the code.  

But, can we think differently?

Instead of [parsing code structures](doc/architecture.md), why cannot we load
them into memory as an efficient binary structure before any further analysis? 

This project adopts flatbuffers, a 1D array to represent the ASTs
as a binary file, and demonstates the improved efficiency and wide
applicability to software development.

[Once installed](doc/installation.md), [our tool](doc/options.md)
[manipulates](doc/usage.md) [source code](doc/example.md) [10x
faster](doc/performance.md). 

Your software development projects may benefit directly from `fast` if you have
used one of the following related tools:

* [antlr4](https://github.com/antlr/antlr4)
* [biyacc](http://biyacc.yozora.moe)
* [flatbuffers](https://github.com/google/flatbuffers)
* [gumtreediff](https://github.com/GumTreeDiff/gumtree)
* [mct](https://github.com/yijunyu/meaningful-changes)
* [protobuf](https://github.com/google/protobuf)
* [rapidxml](https://github.com/dwd/rapidxml)
* [smali](https://github.com/JesusFreke/smali)
* [srcML](http://www.srcml.org/)
* [txl](http://txl.ca)

### Users and contributors
* Bram Adams
* Duy Quoc Nghi Bui
* Julian Harty
* Zhenjiang Hu
* Lingxiao Jiang
* Chunmiao Li
* Qiuchi Li
* Mohammed Sayagh
* Yijun Yu

### Version History

* Updated the schema's Kinds as a union type, accommodating more ANTLR4 languages when needed (currently, Kind => srcml; SmaliKind => smali)
* Added `apk2pb` script to process an APK into a tarball of protobuf representations (TODO: may concatenate all compilation unit pb's into a single archive)
* Fixed some lexer errors in `smaliLexer.g4` (now all code of `Instagram` apk can be processed 10x faster)
* Removed the ANTLR3 branch to take full advantage of latest ANTLR4 (TODO: it may require rewriting the interface to GumTreeDiff)

*0.0.3* (July 6, 2017)

* Added support to ANTLR4 in C++ (which unfortunately caused a conflict in the older dependencies of antlr@2 (required by srcml). There is a workaround 
  (see an update to the installation guide.)
* Modified the code schema to place "tail" information after "child", so that it is easier to remove the shift-reduce error in the application of BiYacc
* Generalised the schema to support other type of information for automated software engineering, such as slicing and diff-patch

*0.0.2* (June 21, 2017)

* Added support for smali code through its ANTLR3 grammar in Java
* Added ANTLR3 libraries to improve GumTreeDiff speed by 2x. 
* Added srcSlice support to improve the speed of forward slicing by 2x.

*0.0.1* (April 11, 2017)

* Initial public release: support round-trip translation between srcML and protobuf/flatbuffers binary ASTs, improving the parsing speed by 10x.
---
© 2017 Yijun Yu. Fast is released under an GPL license;
see [license.txt](license.txt) for details.
