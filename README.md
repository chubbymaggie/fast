# `fast` -- Flattening Abstract Syntax Trees
This tool flattens code structures of abstract syntax trees (ASTs) as binary so that it is more efficient to load and save them between memory and disk, avoiding re-parsing altogether.

## Dependencies
The current implementation is based on `protobuf` and `flatbuffers`, as well as `srcml` which parses code to XML, and [`rapidxml`](https://github.com/dwd/rapidxml) which parses XML documents.

To get it working, we have already included `rapidxml` code in the sources, but you will still need to have the following installed:

* [srcML](http://www.srcml.org/)

* [protobuf](https://github.com/google/protobuf)

* [flatbuffers](https://github.com/google/flatbuffers)


If they aren't installed, the following [Homebrew](https://brew.sh/) commands will get them installed on MacOSX:
```
	$/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ brew tap yijunyu/fast
	$ brew install srcml
	$ brew install fast
```
## Usage
The use the tool is fairly simple. It accepts two file arguments on the command line.
Assuming that you have set `/usr/local/bin` in the `$PATH` variable, just enter
```
	$ fast $input_file_name1.$ext1 $output_file_name2.$ext2
```
Here `$name` is the base name of a file. If `$ext1` is not one of the extensions such as
```
	.pb, .fbs
```
SrcML will be called first to turn them into XML format. If the `$ext1` or `$ext2` is one of these formats, the corresponding load / save functions of `fast` will be invoked to save them into the corresponding binary form.

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

## Performance

In the benchmarks folder if you check out from the `git` repository, you will see much larger examples where `fast` has been applied to speed up the parsing process by several times. That's part of the reasons why we call it "fast".

A report on performance evaluation will be placed under the `doc/` subfolder.
