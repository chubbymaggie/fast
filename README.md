[![Build Status](https://travis-ci.org/f-ast/fast.svg?branch=master)](https://travis-ci.org/f-ast/fast)
[![Coverage Status](https://coveralls.io/repos/github/f-ast/fast/badge.svg?branch=master)](https://coveralls.io/github/f-ast/fast?branch=master)

# `fast` -- Flat Abstract Syntax Trees

Abstract syntax trees (ASTs) are hierarchical, recursive structures for
representing source code.  Parsing them typically requires a full traversal of
the code, which costs O(n) operations.  

But, can we think differently?

Instead of [parsing code structures](doc/architecture.md), why cannot we load
them into memory as an efficient binary structure before any further analysis?
This would only cost O(1) operations.

This project adopts [flatbuffers](https://github.com/google/flatbuffers), a
one-dimensional array to represent the ASTs as a binary file, and demonstates
the improved efficiency and applicability to software development.

[Once installed](doc/installation.md), [our tool](doc/options.md)
[manipulates](doc/usage.md) [source code](doc/example.md) [10x
faster](doc/performance.md). 

## Table of Contents

* [fast \-\- Flat Abstract Syntax Trees](#fast----flat-abstract-syntax-trees)
  * [Table of Contents](#table-of-contents)
  * [When to use fast?](#when-to-use-fast)
    * [Version History](#version-history)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)

## When to use `fast`?
Your software development projects may benefit directly from `fast` if you find
the following activities slow:

### Version History

*TODOs* 

#### Feature requests ####
*0.0.6* TBD
* Created an Python3 parser in C++ based on the [official ANTLR4 grammar in Java](https://github.com/antlr/grammars-v4/blob/master/python3/Python3.g4)
  and extended the FAST schema accordingly, merging the branch `python3';
  Currenly error handling feature is turned off.
* Implemented docker image based on the alpine:edge image, which is much smaller than the ubuntu image

*0.0.5* (August 25, 2017)
* Integrated with [biyacc](http://biyacc.yozora.moe)
* Created a Dockerfile to simplify the deployment
* Implemented normalisation concept from [meaningful changes tool, ASE'11](https://github.com/f-ast/meaningful-changes)
  by migrating the [txl](http://txl.ca)-based implementation, see `-n` option
* Rewritten the interface to speedup [gumtreediff, ASE'14](https://github.com/GumTreeDiff/gumtree) and [treedifferencing, ASE'16](https://github.com/FAU-Inf2/treedifferencing)
* Added colors to the output of diff results so that it is possible to integrate with git on the command line interface
* Added -u option for the YUML extraction (see srcYUML)
* Generated the patch from the diff records of GumTreeDiff integration with BiYacc
* Reduced the size of FAST for slicing

*0.0.4* (August 1, 2017)

* Updated schema's Kinds as a union type, accommodating more ANTLR4 languages when needed
  (currently, Kind => srcml; SmaliKind => smali)
* Removed the ANTLR3 branch to take full advantage of latest ANTLR4 
* Fixed some lexer errors in `smaliLexer.g4` (now all code of `Instagram` apk can be processed 10x faster)
* Added `apk2pb` script to process an APK into a tarball of protobuf representations
* Modified the `Pairs` schema to include hashes
* Formed the `f-ast' team to maintain the project
* Complete slice-diff feature
* Added JSON output for decoding FAST and pipe to jq for further querying
* Added -w option to report the maximum width of the AST (i.e. number of children of the tree nodes), -W limit option to limit the width to the limit
* Added -i option to report the identifiers appeared as function/variable names or comment tokens and tokenize them using intt
* Added -b option to convert bug reports into protobuf format

*0.0.3* (July 6, 2017)

* Generalised the code schema to support automated software engineering activities, e.g. slicing, diffing, cloning
* Placed "tail" information after "child" in schema to remove shift-reduce errors in the application of BiYacc
* Added support to ANTLR4 in C++ (which unfortunately caused a conflict in the older dependencies of antlr@2 (required by srcml).
  A workaround (see an update to the installation guide.)
* Converted srcSlicing CSV output into the supported protobuf schema

*0.0.2* (June 21, 2017)

* Added support for smali code through its ANTLR3 grammar in Java
* Added srcSlice support to improve the speed of forward slicing by 2x
* Added ANTLR3 libraries to improve GumTreeDiff speed

*0.0.1* (April 11, 2017)

* Initial public release: support round-trip translation between srcML and protobuf/flatbuffers binary ASTs, improving the parsing speed by 10x

---
© 2017 F-AST team. FAST is released under BSD license, see [license.txt](license.txt) for details.
