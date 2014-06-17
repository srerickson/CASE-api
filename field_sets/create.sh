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



BI_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @basic_info.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.field_set.id" ` 
echo "... created Basic Info field set with id: $BI_ID"


ST_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @structure.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.field_set.id" ` 
echo "... created structure field set with id: $ST_ID"


ON_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @ontogeny.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.field_set.id" ` 
echo "... created structure field set with id: $ON_ID"


BE_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @behavior.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/field_sets | jsawk "return this.field_set.id" ` 
echo "... created structure field set with id: $BE_ID"


SCHEMA_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"schema\": {\"name\": \"Birds of the Internet\", \"param\":\"boi\", \"field_set_ids\": [$BI_ID, $ST_ID, $ON_ID, $BE_ID]}}"\
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas | jsawk "return this.schema.id" ` 
echo "... created BOI schema with id: $SCHEMA_ID"

