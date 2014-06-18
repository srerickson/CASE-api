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



SCHEMA_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"schema\": {\"name\": \"Birds of the Internet\", \"param\":\"boi\" }}"\
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas | jsawk "return this.schema.id" ` 
echo "... created BOI schema with id: $SCHEMA_ID"



BI_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @basic_info.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created basic info field set with id: $BI_ID"


ST_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @structure.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created structure field set with id: $ST_ID"


ON_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @ontogeny.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created ontogeny field set with id: $ON_ID"


BE_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @behavior.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created behavior field set with id: $BE_ID"


MA_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @mating.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created mating field set with id: $MA_ID"


SM_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @summary.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created summary field set with id: $SM_ID"


MD_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d @metadata.json \
     -H "Authorization: $TOKEN" \
     http://localhost:3000/schemas/$SCHEMA_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created metadata field set with id: $MD_ID"




