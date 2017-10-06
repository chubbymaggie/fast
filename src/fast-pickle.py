import os
import sys
import pickle
from fast_pb2 import Data
from google.protobuf import text_format

if sys.argv[1].endswith('.pb') and (sys.argv[2].endswith('.pickle') or sys.argv[2].endswith('.pkl')):
    data = Data()
    with open(sys.argv[1], 'rb') as f:
        data.ParseFromString(f.read())
        f.close()
    with open(sys.argv[2], 'wb') as f:
        pickle.dump(data, f);
elif sys.argv[2].endswith('.pb') and (sys.argv[1].endswith('.pickle') or sys.argv[1].endswith('.pkl')):
    with open(sys.argv[1], 'rb') as f:
        data = pickle.load(f);
        with open(sys.argv[2], 'wb') as f:
            serializedMessage = data.SerializeToString()
            f.write(serializedMessage)
            f.close()
else:
    print "Please choose either .pb, .pkl, or .pickle as file extensions"
