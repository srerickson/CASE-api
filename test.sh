#!/bin/bash

curl -X PUT \
     -H 'Content-Type:application/json' \
     -d '{"field_definition": {"name": "URL"}}' \
     http://localhost:3000/field_sets/538544013d3d8f018b000001/field_definitions/538544013d3d8f018b000002