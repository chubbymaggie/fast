## Input source code, output efficient structures, and vice versa. 

### Convert from source code to SrcML

  $ fast [/usr/local/share/Hello.java](test/Hello.java) [Hello.xml](test/Hello.xml)

  $ fast [/usr/local/share/example.cc](test/example.cc) [example.xml](test/example.xml)

### Convert SrcML back to source code

  $ fast [Hello.xml](test/Hello.xml) [Hello.java](test/Hello.java)

### Convert SrcML to binary AST

  $ fast [Hello.xml](test/Hello.xml) [Hello.pb](test/Hello.pb)

  $ fast [example.xml](test/example.xml) [example.fbs](test/example.fbs)

### Convert binary AST back to SrcML

  $ fast [Hello.pb](test/Hello.pb) [Hello.xml](test/Hello.xml)

  $ fast [example.fbs](test/example.fbs) [example.xml](test/example.xml)

### Convert binary AST back to source code

  $ fast [Hello.pb](test/Hello.pb) [Hello.java](test/Hello.java)
  
  $ fast [example.fbs](test/example.fbs) [example.cc](test/example.cc)

### Print the textual representation of the protocol buffer using the generated fAST schema.

  $ fast -d [Hello.pb](test/Hello.pb)

  $ fast -d [Hello.pb](test/Hello.pb) [Hello.txt](test/Hello.txt)

### Translate the textual representations into the corresponding protobuf file. 

  $ fast -e [Hello.txt](test/Hello.txt) [Hello.pb](test/Hello.pb)
  
### Keep element positions in binary AST

  $ fast -p [Hello.java](test/Hello.java) [Hello.pb](test/Hello.position.pb)
  
  $ fast -p [Hello.pb](test/Hello.position.pb) [Hello.xml](test/Hello.position.xml)

These commands will keep the line/column positions of the code elements in the
corresponding binary and XML documents.  Note that if "-p" option is not
provided, even if the protobuf document has the code elements' position
information, they will be omitted in the XML document.

### Forward slice source code

  $ fast -p [test/example.cc](test/example.cc) [example.pb](test/example.position.pb)
  
  $ fast -s [example.pb](test/example.position.pb) > [example.slice](test/example.slice)
  
  $ fast -S [example.pb](test/example.position.pb) > [example.slice](test/example.slice)
  
  $ fast -p [test/example.cc](test/example.cc) [example.fbs](test/example.position.fbs)
	
  $ fast -s [example.fbs](test/example.position.fbs) > [example.slice](test/example.slice)
	
  $ fast -S [example.fbs](test/example.position.fbs) > [example.slice](test/example.slice)
	
  $ fast -s [test/example.cc](test/example.cc) > [example.slice](test/example.slice)

  $ fast -s [Hello.java](test/Hello.java) > [Hello.slice](test/Hello.slice)

These commands perform forward program slicing on the source code using the srcSlice tool. 
The modified srcSlice tool can replace parsing the srcML with loading the binary AST, which is much more efficient.

### Convert ANTLR3-based language to binary AST
  $ fast -a [/usr/local/share/DuplicateVirtualMethods.smali](test/DuplicateVirtualMethods.smali) [DuplicateVirtualMethods.pb](test/DuplicateVirtualMethods.pb)
  
  $ fast -d [DuplicateVirtualMethods.pb](test/DuplicateVirtualMethods.pb) > [DuplicateVirtualMethods.txt](test/DuplicateVirtualMethods.txt)
  
  $ fast -a [DuplicateVirtualMethods.pb](test/DuplicateVirtualMethods.pb) [DuplicateVirtualMethods.xml](test/DuplicateVirtualMethods.xml)

These commands convert between Android's smali representation and our protobuf representations. The first command converts SMALI code into a binary AST of
the structural information; the second command decodes the binary AST into textual form; the third command marks up the original SMALI code with XML tags
taken from the binary AST, hence making it similar to SrcML structures (albeit following the underlying ANTLR3 schema). 

### Convert GumTreeDiff editing scripts to binary representations

  $ fast -a [/usr/local/share/DuplicateVirtualMethods.smali](test/DuplicateVirtualMethods.smali) [/usr/local/share/DuplicateVirtualMethods-v2.smali](test/DuplicateVirtualMethods-v2.smali) [DuplicateVirtualMethods-diff.pb](test/DuplicateVirtualMethods-diff.pb)

The command computes the GumTreeDiff editing scripts between the two smali input files and saves the scripts into protobuf structure. The protobuf schema has been extended to record the tree-based delta script. 

