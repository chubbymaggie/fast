## Synopsis

```
$ fast [-bcdef:hijJ:lLn:psStvwW:x] $input [$output]
```

## Options

     -b      Convert bug reports into protobuf format.

     -c      Load the file only, no output if the input is binary AST. 
	     Include comments when -i is used if the output is binary AST.

     -d      Decode the textual representation from protobuf AST input.

     -D      Mark the differences on two FASTs using GumTreeDiff (see ASE'14)/Treedifferencing (see ASE'16).
	     Can be combined with -n option to compute differences after normalisation (see ASE'11).

     -e      Encode the protobuf binary AST from the textual input.

     -f <ext> Select only the files with `ext` extension name.

     -h      Print this help message.

     -i      Tokenizing the identifiers names, and also comments if -c is used.

     -j      Decode the JSON representation from protobuf AST input.

     -J <jq> use `jq` query to process the decoded JSON content, turn on -d -j options

     -l      Process log pairs from cross-language repositories.

     -L      Differentiate on the slices.

     -n <list> Normalise the protobuf representation according to the listed instructions;

     -p      Position (line, column) is added to source code elements.

     -s      Invoke srcSlice. This option turns on the -p option.

     -S      Invoke modified srcSlice to use the binary AST directly.

     -v      Print the version of the build.

     -w      Print the width of the AST.

     -W <width> Transform the AST to tree with limited `width` by introducing intermedate NOP nodes.

     -x      Print the XML output from textual protobuf. This option turns on the -d option.

