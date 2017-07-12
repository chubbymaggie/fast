from __future__ import absolute_import
import sys
import fast_pb2
import json
import json_format
if __name__ == "__main__":
    json.dumps([])
    data = fast_pb2.Data()
    with open(sys.argv[1], 'rb') as f:
         data.ParseFromString(f.read())
         f.close()
         j = json_format.MessageToJson(data)
         print j
