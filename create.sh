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

curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @boi_schema.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas 



