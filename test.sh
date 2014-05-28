#!/bin/bash

curl -X POST \
     -H 'Content-Type:application/json' \
     -d '{"username": "sr.erickson@gmail.com", "password": ""}' \
     http://localhost:3000/authenticate

curl -X GET \
     -H 'Content-Type:application/json' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI1Mzg1Nzk4NDNkM2Q4ZjAyYTMwMDAwMDIiLCJuYW1lIjoiU2V0aCIsImVtYWlsIjoic3IuZXJpY2tzb25AZ21haWwuY29tIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMDU6NTI6MDRaIn0.suu8AmPwtdn4RA8yQ86y4X-rqsGvPPPEYv5brJr0nso' \
     http://localhost:3000/field_sets