[![Build Status](https://travis-ci.org/yijunyu/fast.svg?branch=master)](https://travis-ci.org/yijunyu/fast)
[Coverage](https://htmlpreview.github.io/?https://github.com/yijunyu/fast/blob/master/test/src/index.html)

# `fast` -- Flatten Abstract Syntax Trees
[Once installed](doc/installation.md), [this tool](doc/options.md) [manipulates](doc/usage.md) [source code](doc/example.md) [10x faster](doc/performance.md). 
Your software development projects may benefit directly from `fast` if you use the following:
* [antlr3](https://github.com/antlr/antlr3)
* [biyacc](http://biyacc.yozora.moe)
* [git-dl](https://github.com/yijunyu/git-dl)
* [gumtree](https://github.com/GumTreeDiff/gumtree)
* [srcML](http://www.srcml.org/)
* [srcslice](https://github.com/srcml/srcslice)

### Users and contributors
* Bram Adams
* Duy Quoc Nghi Bui
* Zhenjiang Hu
* Lingxiao Jiang
* Chunmiao Li
* Qiuchi Li
* Mohammed Sayagh

## Related projects
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

### Version History

*0.0.2* (June 21, 2017)

* Added support to smali
* Added antlr3, and gumtreediff to improve diff speed by 2x. 
* Added srcSlice support to improve the speed of forward slicing by 2x.

*0.0.1* (April 11, 2017)

* Initial public release: support round-trip translation between srcML and protobuf/flatbuffers binary ASTs, improving the parsing speed by 10x.
---
© 2017 Yijun Yu. Fast is released under an GPL license;
see [license.txt](license.txt) for details.
