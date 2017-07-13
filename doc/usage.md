## Input source code, output efficient structures, and vice versa. 

All the examples can be obtained when you run the testing script 
with any argument, e.g.:

  $ cd test && keep=1 ./test.sh

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

### Convert ANTLR4-based language to binary AST
  $ fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.pb
  
  $ fast -d DuplicateVirtualMethods.pb > DuplicateVirtualMethods.txt
  
These commands convert between Android's smali representation and our protobuf
representations. The first command converts SMALI code into a binary AST of the
structural information; the second command decodes the binary AST into textual
form. 

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
