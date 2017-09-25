# Table of Contents

* [Input source code, output efficient structures, and vice versa\.](#input-source-code-output-efficient-structures-and-vice-versa)
  * [Convert from source code to SrcML](#convert-from-source-code-to-srcml)
  * [Convert SrcML back to source code](#convert-srcml-back-to-source-code)
  * [Convert SrcML to binary AST](#convert-srcml-to-binary-ast)
  * [Convert binary AST back to SrcML](#convert-binary-ast-back-to-srcml)
  * [Convert binary AST back to source code](#convert-binary-ast-back-to-source-code)
  * [Print the textual representation of the protocol buffer using the generated fAST schema\.](#print-the-textual-representation-of-the-protocol-buffer-using-the-generated-fast-schema)
  * [Print the JSON representation of the protocol buffer using the generated fAST schema\.](#print-the-json-representation-of-the-protocol-buffer-using-the-generated-fast-schema)
  * [Translate the textual representations into the corresponding protobuf file\.](#translate-the-textual-representations-into-the-corresponding-protobuf-file)
  * [Keep element positions in binary AST](#keep-element-positions-in-binary-ast)
  * [Forward slice source code](#forward-slice-source-code)
  * [Convert program whose parser is written in ANTLR4 into binary ASTs](#convert-program-whose-parser-is-written-in-antlr4-into-binary-asts)
  * [Convert Protobuf files into textual format and further turning into a generic XML format](#convert-protobuf-files-into-textual-format-and-further-turning-into-a-generic-xml-format)
  * [Differentiate on the slices](#differentiate-on-the-slices)
  * [Process log pairs from cross\-language repositories](#process-log-pairs-from-cross-language-repositories)
  * [Compute the difference between two artefacts](#compute-the-difference-between-two-artefacts)
  * [Extract yUML from source code (a convenient interface to the srcYUML tool)](#extract-yuml-from-source-code-a-convenient-interface-to-the-srcyuml-tool)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)

## Input source code, output efficient structures, and vice versa. 

### Convert from source code to SrcML

  $ fast Hello.java Hello.xml

  $ fast example.cc example.xml

  $ fast ../test all.xml

### Convert SrcML back to source code

  $ fast Hello.xml Hello.java

### Convert SrcML to binary AST

  $ fast Hello.xml Hello.pb

  $ fast example.xml example.fbs

  $ fast ../test all.pb

  $ fast ../test all.fbs

### Convert binary AST back to SrcML

  $ fast Hello.pb Hello.xml

  $ fast example.fbs example.xml

### Convert binary AST back to source code

  $ fast Hello.pb Hello.java
  
  $ fast example.fbs example.cc

### Print the textual representation of the protocol buffer using the generated fAST schema.

  $ fast -d Hello.pb

  $ fast -d Hello.pb Hello.txt

### Print the JSON representation of the protocol buffer using the generated fAST schema. 

  $ fast -d -j Hello.pb

  $ fast -d -j Hello.pb Hello.json

  $ fast -J '.slices.slice[].file[].function[].name' example.slice.pb

The last command can also pipe results on to a `jq` query, e.g., getting from the slices all the function names.

### Translate the textual representations into the corresponding protobuf file. 

  $ fast -e Hello.txt Hello.pb
  
### Keep element positions in binary AST

  $ fast -p Hello.java Hello.pb
  
  $ fast -p Hello.pb Hello.xml

These commands will keep the line/column positions of the code elements in the
corresponding binary and XML documents.  Note that if "-p" option is not
provided, even if the protobuf document has the code elements' position
information, they will be omitted in the XML document.

### Forward slice source code

  $ fast -p test/example.cc example.pb
  
  $ fast -s example.pb > example.slice
  
  $ fast -S example.pb > example.slice

  $ fast -S example.pb example.slice.pb

  $ fast -p example.cc example.fbs
	
  $ fast -s example.fbs > example.slice
	
  $ fast -S example.fbs > example.slice
	
  $ fast -s example.cc > example.slice

  $ fast -s Hello.java > Hello.slice

These commands perform forward program slicing on the source code using the
srcSlice tool.  The modified srcSlice tool can replace parsing the srcML with
loading the binary AST, which is much more efficient.

### Convert program whose parser is written in ANTLR4 into binary ASTs

  $ fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.pb

  $ fast compat.py compat.pb

  $ fast -d DuplicateVirtualMethods.pb > DuplicateVirtualMethods.txt

  $ fast -d compat.pb > compat.txt
  
These commands convert between ANTLR4 parsing trees and our protobuf
representations. The first command converts Android App's SMALI code into a
binary AST of the structural information; the second command converts Python 3
code into a binary AST; and the third / fourth command decodes the binary ASTs
into textual form. 

### Convert Protobuf files into textual format and further turning into a generic XML format
  $ fast -d DuplicateVirtualMethods.smali.pb > DuplicateVirtualMethods.smali.pb.txt

  $ fast -x DuplicateVirtualMethods.smali.pb.txt > DuplicateVirtualMethods.smali.pb.txt.xml

### Differentiate on the slices

  $fast -L slice1.pb slice2.pb slice-diff.pb

Assuming slice1.pb and slice2.pb are outputs of progra slicing using the option
`-S` on two versions of the code, the output of this command is a diff
representation of the differences.

### Process log pairs from cross-language repositories
  $cat codelabel_new.csv > a.csv

  $fast -l a.csv a.pb

Assuming that the input file is a comma-separate file where each row of the
record indicates the project name, the hash of a changeset of the source
project, diff position of the source project, textual differences of the source
project, the hash of the changeset of the target project, diff positions of the
target project, textual differences of the target project, and the judgement
whether the pair of differences are clones.  The output of the command is a
protobuf representation of the above pairs.

### Compute the difference between two artefacts

  $fast -D Hello1.java Hello2.java

The command will print the compared files on the terminal, with colors
indicating the changes.  By default, something in yellow color on the 1st file
will be changed to something in blue color on the 2nd file; and something in
red color on the 1st file will be deleted, while something in green color on
the 2nd file will be added.

  $fast Hello1.java Hello1.pb
  $fast Hello2.java Hello2.pb
  $fast -D Hello1.pb Hello2.pb
  $fast Hello1Hello2-diff.pb-Hello2.pb.pb Hello-patch.xml

The command will generate the patch that merged the diff records on Hello1.pb and
Hello2.pb so that one can see all the four types of tree-based changes into 
one single structure. The XML representation of this patch structure would indicate
them as:
   -  DELETED
   +  ADDED
  -+  UPDATED or MOVED

### Extract yUML from source code (a convenient interface to the srcYUML tool)

  $fast -u . t.yuml

The command will extract a [yUML](https://yuml.me) specification from source code in the current folder. 
Under the hood it invokes the functionality of [srcYUML](https://github.com/srcML/srcUML).

