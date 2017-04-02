#!/bin/bash
is_pb=0
is_fbs=0
for f in "$@"; do
   if [ "${f##*.}" == "pb" ]; then
	is_pb=1
   fi
   if [ "${f##*.}" == "fbs" ]; then
	is_fbs=1
   fi
   if [ "${f##*.}" == "xml" ]; then
	is_xml=1
   fi
done
if [ "$is_fbs" == "1" ]; then
   fast_fbs $@
elif [ "$is_xml" == "1" ]; then
   fast_pb $@
elif [ "$is_pb" == "1" ]; then
   fast_pb $@
else
   echo Usage: fast input_file output_file
   echo where at least one of the files has file extension .pb, .fbs, or .xml
fi
