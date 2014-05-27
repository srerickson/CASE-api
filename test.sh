#!/bin/bash

curl -X PUT \
     -H 'Content-Type:application/json' \
     -d '{"field_definition": {"name": "Tastier8"}}' \
     http://localhost:3000/schemas/538411be3d3d8f5936000001/field_sets/538411be3d3d8f5936000002/field_definitions/538411be3d3d8f5936000005