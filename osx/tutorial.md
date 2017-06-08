
Step 1: 
=====

Parse a source code file by using srcml with the parameter "--position":
-------
srcml file --position >parsedCode.xml
-------

You can also generate one srcml file for the whole project:
-------
cd project
srcml * --position >parsedCode.xml
--------
Step 2:
=====

Execute the forward slicer srcSlice:
--------
./srcSlice parsedCode.xml
--------
The output represents the forward slice of each variable in the code. 