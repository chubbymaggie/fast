import os
import sys

import tensorflow as tf
from tensorflow_fold.util import proto_tools
from fast_pb2 import Data
from google.protobuf import text_format

proto_tools.map_proto_source_tree_path("", os.getcwd())
proto_tools.import_proto_file("fast.proto")

data = Data()
with open(sys.argv[1], 'rb') as f:
           data.ParseFromString(f.read())
           f.close()
#print(data))
print(data.pairs.pair[0].type)
#print(data.slices.slice[0].file[0].name)
#print(data.slices.slice[0].file[0].function[0].variable[0].name)
#print(data.slices.slice[0].file[0].function[0].variable[0].defn[0].lineno)
