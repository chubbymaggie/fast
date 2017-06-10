[![Build Status](https://travis-ci.org/yijunyu/fast.svg?branch=master)](https://travis-ci.org/yijunyu/fast)
# `fast` -- Flattening Abstract Syntax Trees
This tool flattens code structures of abstract syntax trees (ASTs) as binary so that it is more efficient to load and save them between memory and disk, avoiding re-parsing altogether.

## Performance
In the benchmarks folder if you check out from the `git` repository, you will see much larger examples where `fast` has been applied to speed up the parsing process by up to 100 times. 

![Benchmarks 1. Most popular projects in 5 programming languages](https://github.com/yijunyu/fast/raw/master/benchmarks/benchmarks1.png "The projects are selected from those with the most stars on GitHub.") ![Benchmarks 2. Bug related commits in evolving artefacts in Java](https://github.com/yijunyu/fast/raw/master/benchmarks/benchmarks2.png "The projects are selected from academic studies on the bug localization problems.")

That's part of the reasons why we call it "fast".

A report on performance evaluation will be placed under the `doc/` subfolder.

## Synopsis

```
$ fast [-cehpsSt] $input_file_name.$ext1 [$output_file_name.$ext2]
```

## Description
The use of the tool is fairly simple. It accepts two file arguments on the command line.
Assuming that you have set `/usr/local/bin` in the `$PATH` variable, just enter

Here `$name` is the base name of a file. If `$ext1` is not one of the extensions such as
```
	.pb, .fbs
```
SrcML will be called first to turn them into XML format. If the `$ext` 
is one of these formats, the corresponding load / save functions of
`fast` will be invoked to convert them from / to the corresponding binary form.

If `$ext` is `.txt`, then `protoc` will be called to convert it between `.pb` and textual format.

If the `output_file_name` is unspecified, the output will be directed to the standard output.

The following options are available:

     -c      Load the file only, no output.

     -d      Decode the textual representation from protobuf AST input.

     -e      Encode the protobuf binary AST from the textual input.

     -h      Print this help message.

     -p      Position (line, column) is added to source code elements.

     -s      Invoke srcSlice. This option turns on the -p option.

     -S      Invoke modified srcSlice to use the binary AST directly.


## Dependencies
The current implementation is based on `protobuf` and `flatbuffers`, as well as `srcml` which parses code to XML, and [`rapidxml`](https://github.com/dwd/rapidxml) which parses XML documents.

To get it working, we have already included `rapidxml` code in the source, but it has dependencies on the following software:

* [srcML](http://www.srcml.org/)

* [protobuf](https://github.com/google/protobuf)

* [flatbuffers](https://github.com/google/flatbuffers)

If they aren't installed, the following commands will get them installed:
### MacOSX using [Homebrew](https://brew.sh/) 
```
	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ brew tap yijunyu/fast
	$ brew install fast
```
The 1st line is optional, it will install Homebrew if you hadn't got it.
### Ubuntu Linux using Debian packages:
```
	$ sudo apt-get install apt-transport-https
	$ sudo echo deb http://yijunyu.github.io/ubuntu ./ >> /etc/apt/sources.list
	$ sudo apt-get update
	$ sudo apt-get install fast
```
Specifically, the 1st line is to support HTTPS transport protocol for the repository on github.io; 
the 2nd line is to update the list of repositories on your machine.
## Usage
Here are a few examples:
```
	$ fast test/Hello.java Hello.xml
	$ fast test/test.cc test.xml
```
These commands will translate the `Hello.java` Java code or the `test.cc` C++ code
into the corresponding XML document `Hello.xml` or `test.xml`, respectively.
```
	$ fast Hello.xml Hello.java
```
This command will translate the XML document `Hello.xml` back into the corresponding Java code `Hello.java`.
```
	$ fast Hello.xml Hello.pb
	$ fast test.xml test.fbs
```
These commands will translate the XML document `Hello.xml` into the corresponding Protocol Buffer (`.pb`) or 
FlatBuffers (`.fbs`) binary in `Hello.pb` or `Hello.fbs`, respectively.
```
	$ fast Hello.pb Hello.xml
	$ fast test.fbs test.xml
```
These commands will translate the binary representations into the corresponding XML document `Hello.xml`.
```
	$ fast Hello.pb Hello.java
	$ fast test.fbs test.cc
```
These commands will translate the binary representations into the corresponding code files. 
```
	$ fast -d Hello.pb
	$ fast -d Hello.pb Hello.txt
```
These commands will print the textual representation of the protocol buffer using the generated fAST schema.
The first one prints it to the standard output, while the second one save it into a textual file.
```
	$ fast -e Hello.txt Hello.pb
```
This commands will translate the textual representations into the corresponding protobuf file. 
```
	$ fast -p Hello.java Hello.pb
	$ fast -p Hello.pb Hello.xml
```
These commands will keep the line/column positions of the code elements in the
corresponding binary and XML documents.  Note that if "-p" option is not
provided, even if the protobuf document has the code elements' position
information, they will be omitted in the XML document.
```
	$ fast -p test.cc test.pb
	$ fast -s test.pb
	$ fast -p test.cc test.fbs
	$ fast -s test.fbs
	$ fast -S test.fbs
	$ fast -s test.cc
	$ fast -s Hello.java
```
These commands perform forward program slicing on the source code using the srcSlice tool. 
