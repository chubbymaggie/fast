## Synopsis

```
$ fast [-cdehpsStx] $input [$output]
```

## Options

     -c      Load the file only, no output.

     -d      Decode the textual representation from protobuf AST input.

     -e      Encode the protobuf binary AST from the textual input.

     -h      Print this help message.

     -p      Position (line, column) is added to source code elements.

     -s      Invoke srcSlice. This option turns on the -p option.

     -S      Invoke modified srcSlice to use the binary AST directly.

     -x      Print the XML output from textual protobuf. This option turns on the -d option.

