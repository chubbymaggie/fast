[![Build Status](https://travis-ci.org/yijunyu/fast.svg?branch=master)](https://travis-ci.org/yijunyu/fast)
[![Coverage Status](https://coveralls.io/repos/github/yijunyu/fast/badge.svg?branch=master)](https://coveralls.io/github/yijunyu/fast?branch=master)

# `fast` -- Flat Abstract Syntax Trees

Abstract syntax trees (ASTs) are hierarchical, recursive structures for
representing source code.  Parsing them typically requires a full traversal of
the code.  

But, can we think differently?

Instead of [parsing code structures](doc/architecture.md), why cannot we load
them into memory as an efficient binary structure before any further analysis? 

This project adopts [flatbuffers](https://github.com/google/flatbuffers), a one-dimensional array to represent the ASTs
as a binary file, and demonstates the improved efficiency and applicability to
software development.

[Once installed](doc/installation.md), [our tool](doc/options.md)
[manipulates](doc/usage.md) [source code](doc/example.md) [10x
faster](doc/performance.md). 

Your software development projects may benefit directly from `fast` if you find
one of the following activities not fast enough:

### *Parsing* => [10-100x faster](doc/performance.md)
* Java, C, C++, C#, Objective C -- supported by [srcML](http://www.srcml.org/)
* Smali/Android -- supported by [smali](https://github.com/JesusFreke/smali) in [apktool](https://ibotpeaches.github.io/Apktool)
* or one of [175 programming languages](https://github.com/antlr/grammars-v4) supported by [antlr4](https://github.com/antlr/antlr4)
### *Program slicing* => [2.5x faster](doc/performance.md)
* [srcslice](https://github.com/srcML/srcSlice) for [efficient and scalable forward slicing](http://www.cs.kent.edu/~jmaletic/papers/JSEP14.pdf)
### *Diff-Patching* => smaller and faster (to measure)
* [gumtreediff](https://github.com/GumTreeDiff/gumtree)
* [mct](https://github.com/yijunyu/meaningful-changes)
### *Synchronisation* => smaller and faster (to measure)
* [biyacc](http://biyacc.yozora.moe)
### *Clone Detection* => more precise (to measure)
* [deckard](https://github.com/skyhover/Deckard)

## Contributors
| Contributors | Expertise |
| ---------------------- |:-------------:| 
| Bram Adams 		         |program slicing|
| Duy Quoc Nghi Bui 	   |clone detection|
| Julian Harty 		       |mobile analytics|
| Zhenjiang Hu 		|bidirectional programming|
| Lingxiao Jiang 	|clone detection|
| Chunmiao Li 		|bidirectional programming|
| Qiuchi Li 		|information retrieval|
| Angus Marshall 	|mobile forensics|
| Mohammed Sayagh 	|program slicing|
| Meng Wang		|bidirectional programming|
| Yijun Yu		|compiler optimization|

### Version History

*TODOs* 

#### Feature requests ####
* Complete slice-diff
* Extract code pair hashes from Git repositories
* Reimplement normalisation concept from [meaningful changes tool, ASE'11](https://github.com/yijunyu/meaningful-changes)
  by migrating the [txl](http://txl.ca)-based implementation
* Rewrite the interface to [gumtreediff, ASE'14](https://github.com/GumTreeDiff/gumtree) to make it faster
* Integrate with [biyacc](http://biyacc.yozora.moe) <= Chunmiao Li
* Concatenate compilation units' FAST into a single archive in FAST, retaining folder hierarchy <= Qiuchi Li
* Support more ANTLR4 languages (long term)

#### Known bugs to fix #### 
* Generate efficient slices directly from merged srcML inputs (fast -S all.xml)

*0.0.4* TBD

* Updated schema's Kinds as a union type, accommodating more ANTLR4 languages when needed
  (currently, Kind => srcml; SmaliKind => smali)
* Removed the ANTLR3 branch to take full advantage of latest ANTLR4 
* Fixed some lexer errors in `smaliLexer.g4` (now all code of `Instagram` apk can be processed 10x faster) => Angus Marshall
* Added `apk2pb` script to process an APK into a tarball of protobuf representations  => Angus Marshall

*0.0.3* (July 6, 2017)

* Generalised the code schema to support automated software engineering activities, e.g. slicing, diffing, cloning
* Placed "tail" information after "child" in schema to remove shift-reduce errors in the application of BiYacc => Chunmiao Li
* Added support to ANTLR4 in C++ (which unfortunately caused a conflict in the older dependencies of antlr@2 (required by srcml).
  A workaround (see an update to the installation guide.) => Meng Wang
* Converted srcSlicing CSV output into the supported protobuf schema => Qiuchi Li

*0.0.2* (June 21, 2017)

* Added support for smali code through its ANTLR3 grammar in Java => Julian Harty
* Added srcSlice support to improve the speed of forward slicing by 2x. => Bram Adams
* Added ANTLR3 libraries to improve GumTreeDiff speed.

*0.0.1* (April 11, 2017)

* Initial public release: support round-trip translation between srcML and protobuf/flatbuffers binary ASTs, improving the parsing speed by 10x.

## Acknowledgement
Our tool cannot be made without standing on the shoulders of these great tools:

* [antlr4](https://github.com/antlr/antlr4)
* [biyacc](http://biyacc.yozora.moe)
* [deckard](https://github.com/skyhover/Deckard)
* [flatbuffers](https://github.com/google/flatbuffers)
* [gumtreediff](https://github.com/GumTreeDiff/gumtree)
* [mct](https://github.com/yijunyu/meaningful-changes)
* [protobuf](https://github.com/google/protobuf)
* [rapidxml](https://github.com/dwd/rapidxml)
* [smali](https://github.com/JesusFreke/smali)
* [srcML](http://www.srcml.org/)
* [txl](http://txl.ca)

---
© 2017 Yijun Yu. FAST is released under GPL v3, see [license.txt](license.txt) for details.
