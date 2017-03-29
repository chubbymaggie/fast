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
done
if [ "$is_pb" == "1" ]; then
   fast_pb $@
fi
if [ "$is_fbs" == "1" ]; then
   fast_fbs $@
fi
