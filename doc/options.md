## Synopsis

```
$ fast [-cdehlLpsStx] $input [$output]
```

## Options

     -c      Load the file only, no output.

     -d      Decode the textual representation from protobuf AST input.

     -e      Encode the protobuf binary AST from the textual input.

     -h      Print this help message.

     -l      Process log pairs from cross-language repositories.

     -L      Differentiate on the slices.

     -p      Position (line, column) is added to source code elements.

     -s      Invoke srcSlice. This option turns on the -p option.

     -S      Invoke modified srcSlice to use the binary AST directly.

     -x      Print the XML output from textual protobuf. This option turns on the -d option.

