@debug
Feature: CRUD on Reqres

Background:
* url "https://reqres.in/"
* def payload = read('JsonPayload.json')

Scenario: List all users
Given path "api/users"
And param page = 2
When method GET
Then status 200
And print response

Scenario: Create new user
Given path "api/users"
And request payload
When method POST
Then status 201
And print response
And match response == "#object"
And match response.id == "#present"

* def empid = response.id

# Deleting the user
Given path "api/users/" + empid
When method DELETE
Then status 204
And print response

# Searching for the deleted user
Given path "api/users/" + empid
When method GET
Then assert responseStatus == 404
And print responseStatus
And print response