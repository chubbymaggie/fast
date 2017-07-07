[![Build Status](https://travis-ci.org/yijunyu/fast.svg?branch=master)](https://travis-ci.org/yijunyu/fast)
[Coverage](https://htmlpreview.github.io/?https://github.com/yijunyu/fast/blob/master/test/src/index.html)

# `fast` -- Flat Abstract Syntax Trees

Abstract syntax trees (ASTs) are hierarchical, recursive structures for
representing source code.  Parsing them typically requires a full traversal of
the code.  

But, can we think differently?

Instead of [parsing code structures](doc/architecture.md), why cannot we load them before any further
analysis? 

This project adopts flatbuffers, a one diemnsional array to represent the ASTs
as a binary file, and demonstates the improved efficiency and wide
applicability to software development.

[Once installed](doc/installation.md), [our tool](doc/options.md)
[manipulates](doc/usage.md) [source code](doc/example.md) [10x
faster](doc/performance.md). 

Your software development projects may benefit directly from `fast` if you have
used one of the following related tools:

* [antlr3](https://github.com/antlr/antlr3)
* [biyacc](http://biyacc.yozora.moe)
* [flatbuffers](https://github.com/google/flatbuffers)
* [gumtreediff](https://github.com/GumTreeDiff/gumtree)
* [meaningful-changes](https://github.com/yijunyu/meaningful-changes)
* [protobuf](https://github.com/google/protobuf)
* [rapidxml](https://github.com/dwd/rapidxml)
* [smali](https://github.com/JesusFreke/smali)
* [srcML](http://www.srcml.org/)
* [txl](http://txl.ca)

### Users and contributors
* Bram Adams
* Duy Quoc Nghi Bui
* Zhenjiang Hu
* Lingxiao Jiang
* Chunmiao Li
* Qiuchi Li
* Mohammed Sayagh
* Yijun Yu

### Version History

* Fixed some lexer errors in smaliLexer.g4

*0.0.3* (July 6, 2017)

* Added support to Antlr4 (which unfortunately caused a conflict in the older dependencies of antlr@2 (required by srcml). There is a workaround (see an update to the installation guide.)
* Modified the code schema to place "tail" information after "child", so that it is easier to remove the shift-reduce error in the application of BiYacc
* Generalised the schema to support other type of information for automated software engineering, such as slicing and diff-patch

*0.0.2* (June 21, 2017)

* Added support to smali
* Added antlr3, and gumtreediff to improve diff speed by 2x. 
* Added srcSlice support to improve the speed of forward slicing by 2x.

*0.0.1* (April 11, 2017)

* Initial public release: support round-trip translation between srcML and protobuf/flatbuffers binary ASTs, improving the parsing speed by 10x.
---
© 2017 Yijun Yu. Fast is released under an GPL license;
see [license.txt](license.txt) for details.
