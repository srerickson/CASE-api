#!/bin/bash

TOKEN=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d '{"username": "sr.erickson@gmail.com", "password": "12345"}' \
     http://localhost:3000/authenticate | sed 's/\"//g'`


AUTH=`curl -s -X GET \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/restricted`
echo "... authorized?: $AUTH"



FS_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d basic_info.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.id" ` 
echo "... created Basic Info field set with id: $FS_ID"


FS_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d structure.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.id" ` 
echo "... created structure field set with id: $FS_ID"
