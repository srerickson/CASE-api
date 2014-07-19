#!/bin/bash

# BASE_URL="http://case-demo.herokuapp.com/"
BASE_URL="localhost:3000"

USERNAME="sr.erickson@gmail.com"
PASSWORD="birds"

TOKEN=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\"}" \
     $BASE_URL/authenticate | jsawk "return this.token"`
echo "... token: $TOKEN"

AUTH=`curl -s -X GET \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/users/current_user`
echo "... authorized?: $AUTH"


SCH_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d '{"schema": {"name":"Schema Me", "param": "crap"}}' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas | jsawk "return this.schema.id"`
echo "... created schema with id: $SCH_ID"


SCH_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d '{"schema":{"description":"describe me"}}' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID`
echo "... updating schema description: $SCH_UPDATE"


FS_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d '{"field_set": {"name": "Basic Info", "param": "basic_info"}}' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets | jsawk "return this.field_set.id" ` 
echo "... created field set with id: $FS_ID"


SCH_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d "{\"schema\":{\"field_set_ids\": [$FS_ID]}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID`
echo "... updated schema (id: $SCH_ID) to include field set (id: $FS_ID): $SCH_UPDATE"


FD_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"field_definition\":{\"name\": \"URL\", \"param\": \"url\"}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID/field_definitions| jsawk "return this.field_definition.id" `
echo "... added field definition to field set (id: $FS_ID) with id: $FD_ID"


FD2_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"field_definition\":{\"name\": \"Brand\", \"param\": \"brand\"}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID/field_definitions | jsawk "return this.field_definition.id" `
echo "... added another field definition to field set (id: $FS_ID) with id: $FD2_ID"


FD_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d "{\"field_definition\":{\"description\": \"web address ...\"}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID/field_definitions/$FD_ID `
echo "... updated field definition (id: $FD_ID): $FD_UPDATE"


FD2_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d "{\"field_definition\":{\"param\": null}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID/field_definitions/$FD_ID `
echo "... updated field definition with invalid data (should fail): $FD2_UPDATE"


FD2_DELETE=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID/field_definitions/$FD2_ID | jsawk "return this.field_definition.id"`
echo "... deleted field definition with id: $FD2_DELETE"


CASE_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d '{"case": {"name": "Echo Park"}}' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/cases | jsawk "return this.case.id" `
echo "... created case with id: $CASE_ID"


CASE_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d '{"case": {"description": "Echo Park is a place in Los Angeles"}}' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/cases/$CASE_ID `
echo "... updated case (id: $CASE_ID): $CASE_UPDATE"


VAL='{"text": "one two three"}'
FV_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -d "{\"field_value\": {\"value\": $VAL, \"field_definition_id\": $FD_ID}}" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/cases/$CASE_ID/field_values | jsawk "return this.field_value.id" `
echo "... created field value for case $CASE_ID, field def $FD_ID: $FV_ID"


VAL='{"array": ["one","two","three"]}'
FV_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -d "{\"field_value\": {\"value\": $VAL} }" \
     -H "Authorization: $TOKEN" \
     $BASE_URL/cases/$CASE_ID/field_values/$FV_ID `
echo "... update field value (id: $FV_ID): $FV_UPDATE"


DEL_FS=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID/field_sets/$FS_ID | jsawk "return this.field_set.id" `
echo "... deleted field set with id: $DEL_FS"


# Evaluations Test

EVAL_SET='{"set": {"name": "An Eval Set", "locked": false}}'
ES_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     -d "$EVAL_SET" \
     $BASE_URL/evaluations/sets | jsawk "return this.set.id"`
echo "... created an evaluation set with id: $ES_ID"


EVAL_SET='{"set": {"locked": true}}'
ES_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     -d "$EVAL_SET" \
     $BASE_URL/evaluations/sets/$ES_ID`
echo "... updating an evaluation set with id: $ES_UPDATE"


EVAL_Q='{"question": {"question": "what is your favorite color?"}}'
EQ_ID=`curl -s -X POST \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     -d "$EVAL_Q" \
     $BASE_URL/evaluations/sets/$ES_ID/questions | jsawk "return this.question.id"`
echo "... created an evaluation question in evaluation set ($ES_ID) with id: $EQ_ID"


EVAL_Q='{"question": {"is_subquestion": true}}'
EQ_UPDATE=`curl -s -X PUT \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     -d "$EVAL_Q" \
     $BASE_URL/evaluations/sets/$ES_ID/questions/$EQ_ID`
echo "... updated the evaluation question ($EQ_ID): $EQ_UPDATE"




# Cleanup

EQ_DEL=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/evaluations/sets/$ES_ID/questions/$EQ_ID | jsawk "return this.question.id"`
echo "... deleted the evaluation question ($EQ_ID): $EQ_DEL"


DEL_ES=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/evaluations/sets/$ES_ID | jsawk "return this.set.id"`
echo "... deleted an evaluation set with id: $ES_ID"


DEL_SCH=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/schemas/$SCH_ID | jsawk "return this.schema.id" `
echo "... deleted schema with id: $DEL_SCH"


DEL_CASE=`curl -s -X DELETE \
     -H 'Content-Type:application/json' \
     -H "Authorization: $TOKEN" \
     $BASE_URL/cases/$CASE_ID | jsawk "return this.case.id" `
echo "... deleted case with id: $DEL_CASE"


