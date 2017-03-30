# `fast` -- Flattening Abstract Syntax Trees
This tool flattens code structures of abstract syntax trees (ASTs) as binary so that it is more efficient to load and save them between memory and disk, avoiding re-parsing altogether.

## Dependencies
The current implementation is based on `protobuf` and `flatbuffers`, as well as `srcml` which parses code to XML.
To get it working, you will need to have the following installed:

* [srcML](http://www.srcml.org/)

* [protobuf](https://github.com/google/protobuf)

* [flatbuffers](https://github.com/google/flatbuffers)

Usually the `Makefile` file can detect whether or not these commands are available. If they aren't, it could fetch and install them in one command:
```
	$ make
```
You can then install the tool using the following single command to the destiation
folder such as `/usr/local/bin/fast`. 
 
```
	$ sudo make install
```
## Usage

The use the tool is fairly simple. It accept two file arguments on the command line.
Assuming that you have set /usr/local/bin in the PATH, then just enter
```
	$ fast $name1.$ext1 $name2.$ext2
```
Here `$name` is the base name of a file. If `$ext` is one of the extensions such as
```
	.h, .java., .c, .cpp, .m
```
The srcML will be called to turn them into XML format.

If the $ext? is one of 
```
	.pb, .fbs
```
then the corresponding load / save functions of `fast` will be invoked to save them into the corresponding binary form.

Here are a few examples:
```
	$ fast test/Hello.java Hello.xml
	$ fast test/test.cc test.xml
```
These command will translate the `Hello.java` Java code or the `test.cc` C++ code
into the corresponding XML document as `Hello.xml` or `test.xml`.
```
	$ fast Hello.xml Hello.java
```
This command will translate the `Hello.xml` XML document back into the corresponding Java code in `Hello.java`.
```
	$ fast Hello.xml Hello.pb
	$ fast Hello.xml Hello.fbs
```
These commands will translate the Hello.xml XML document into the corresponding Protocol Buffer (`.pb`) or 
FlatBuffers (`.fbs`) binary in `Hello.pb` or `Hello.fbs`, respectively.
```
	$ fast Hello.pb Hello.xml
	$ fast Hello.fbs Hello.xml
```
These commands will translate the binary representations into the corresponding XML documents.
```
	$ fast Hello.pb Hello.java
	$ fast Hello.fbs Hello.java
```
These commands will translate the binary representations into the corresponding Java code files.

## Performance

In the benchmarks folder if you check out from the `git` repository, you will see much larger examples where fast has been used to speed up the parsing process by several times. That's why we call it "fast".

A report on the performance evaluation is placed in the `doc/` subfolder.

Cheers,
[http://mcs.open.ac.uk/yy66](Yijun Yu)

```
Dr. Yijun YU
Senior Lecturer in Computing
School of Computing & Communications
Faculty of Science, Technology, Engineering & Maths
The Open University, UK
2nd floor, Janie Lee Building, Walton Hall
Milton Keynes MK7 6AA
```
