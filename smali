#!/bin/bash
export CLASSPATH=/usr/local/lib/smali.jar:/usr/local/lib/protobuf-java-3.3.1.jar:/usr/local/lib/core-2.1.0-SNAPSHOT.jar:/usr/local/lib/reflections-0.9.10.jar:/usr/local/lib/smali-2.2.1-93a43730-dirty-fat.jar:/usr/local/lib/javassist-3.18.2-GA.jar:/usr/local/lib/client-2.1.0-SNAPSHOT.jar:/usr/local/lib/client.diff-2.1.0-SNAPSHOT.jar:/usr/local/lib/rendersnake-1.9.0.jar:/usr/local/lib/trove4j-3.0.3.jar:/usr/local/lib/simmetrics-core-3.2.3.jar
java="jdb -sourcepath src"
java=java
$java Smali $@
