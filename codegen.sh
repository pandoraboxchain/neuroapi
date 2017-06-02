#!/bin/bash

python -m grpc_tools.protoc -Iapi --python_out=sdk/python/mwapi --grpc_python_out=sdk/python/mwapi api/mwapi.proto
sed -e 's/mwapi_pb2_grpc/services/g' < sdk/python/mwapi/mwapi_pb2_grpc.py > sdk/python/mwapi/services.py
sed -e 's/mwapi_pb2/messages/g' < sdk/python/mwapi/services.py > sdk/python/mwapi/temp.py
sed -e 's/import messages as mwapi__pb2/from . import messages as msgs/g' < sdk/python/mwapi/temp.py > sdk/python/mwapi/services.py
sed -e 's/mwapi_pb2/messages/g' < sdk/python/mwapi/mwapi_pb2.py > sdk/python/mwapi/messages.py
rm sdk/python/mwapi/mwapi_pb2.py
rm sdk/python/mwapi/mwapi_pb2_grpc.py
rm sdk/python/mwapi/temp.py
