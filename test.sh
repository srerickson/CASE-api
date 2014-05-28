#!/bin/bash

# curl -X POST \
#      -H 'Content-Type:application/json' \
#      -d '{"username": "sr.erickson@gmail.com", "password": ""}' \
#      http://localhost:3000/authenticate

# make sure we are authorized
curl -X GET \
     -H 'Content-Type:application/json' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
     http://localhost:3000/restricted
 echo "\n--------------------------------\n"

# # Create a Field Set
# curl -X POST \
#      -H 'Content-Type:application/json' \
#      -d @field_set.json \
#      -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
#      http://localhost:3000/field_sets 

#  echo "\n--------------------------------\n"

# List Cases
curl -X GET \
     -H 'Content-Type:application/json' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
     http://localhost:3000/cases

 echo "\n-------------------------------\n"

# Create a Case
# curl -X POST \
#      -H 'Content-Type:application/json' \
#      -d '{"case": {"name": "Echo Park"}}' \
#      -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
#      http://localhost:3000/cases

#  echo "\n--------------------------------\n"


Create a Field Value
curl -X POST \
     -H 'Content-Type:application/json' \
     -d '{"field_value": {"field_definition_id": "538615593d3d8ffca5000003", "value": "testtting123"}}' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
     http://localhost:3000/cases/538614cd3d3d8ffca5000001/field_values

 echo "\n--------------------------------\n"


# Update a Field Value
curl -X PUT \
     -H 'Content-Type:application/json' \
     -d '{"field_value": {"value": "Revised Response2"}}' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
     http://localhost:3000/cases/538614cd3d3d8ffca5000001/field_values/5386161b3d3d8ffca5000009

 echo "\n--------------------------------\n"


# Delete a Field Value
curl -X DELETE \
     -H 'Content-Type:application/json' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTcyNzczMn0.eyJfaWQiOiI1Mzg2MTM3MDNkM2Q4ZmUzMjMwMDAwMDEiLCJlbWFpbCI6InNyLmVyaWNrc29uQGdtYWlsLmNvbSIsIm5hbWUiOiJTZXRoIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMTY6NDg6NDhaIn0.bEhOYgf7v9S8PjOTVM3R1efQ7fAUqashVDYKyCa1gkY' \
     http://localhost:3000/cases/538614cd3d3d8ffca5000001/field_values/5386161b3d3d8ffca5000009

 echo "\n--------------------------------\n"

