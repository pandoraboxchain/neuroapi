#!/bin/bash

python -m grpc_tools.protoc -Iapi --python_out=sdk/python/neuromwapi --grpc_python_out=sdk/python/neuromwapi api/neuromwapi.proto
sed -e 's/neuromwapi_pb2_grpc/services/g' < sdk/python/neuromwapi/neuromwapi_pb2_grpc.py > sdk/python/neuromwapi/temp.py
sed -e 's/neuromwapi_pb2/messages/g' < sdk/python/neuromwapi/temp.py > sdk/python/neuromwapi/services.py
sed -e 's/neuromwapi__pb2/msgs/g' < sdk/python/neuromwapi/services.py > sdk/python/neuromwapi/temp.py
sed -e 's/import messages as msgs/from . import messages as msgs/g' < sdk/python/neuromwapi/temp.py > sdk/python/neuromwapi/services.py
sed -e 's/neuromwapi_pb2/messages/g' < sdk/python/neuromwapi/neuromwapi_pb2.py > sdk/python/neuromwapi/messages.py
rm sdk/python/neuromwapi/neuromwapi_pb2.py
rm sdk/python/neuromwapi/neuromwapi_pb2_grpc.py
rm sdk/python/neuromwapi/temp.py

cd sdk/python
python setup.py sdist
twine upload dist/*

cd ../..