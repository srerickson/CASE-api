#!/bin/bash

curl -X POST \
     -H 'Content-Type:application/json' \
     -d '{"username": "sr.erickson@gmail.com", "password": "Oswald89"}' \
     http://localhost:3000/authenticate

curl -X GET \
     -H 'Content-Type:application/json' \
     -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImV4cCI6MTQwMTI2NDAwM30.eyJfaWQiOiI1Mzg1Nzk4NDNkM2Q4ZjAyYTMwMDAwMDIiLCJuYW1lIjoiU2V0aCIsImVtYWlsIjoic3IuZXJpY2tzb25AZ21haWwuY29tIiwidXBkYXRlZF9hdCI6IjIwMTQtMDUtMjhUMDU6NTI6MDRaIn0.7lFXfLphyeWxhpjZuRtKW72Xp83ya2rkGa2NER09FE8' \
     http://localhost:3000/restricted