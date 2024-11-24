*** Settings ***
Library    RequestsLibrary
Variables    ../resources/variables.py

*** Test Cases ***
Login API Test
    [Tags]    api
    Create Session    jsonplaceholder    ${API_URL}
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.json()}

Test Postman Echo API
    [Tags]    api
    Create Session    postman    https://postman-echo.com
    ${response}=    POST On Session    postman    /post    json={"key": "value"}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.json()}


Delete Post - JSONPlaceholder
    [Tags]    api
    Create Session    jsonplaceholder    https://jsonplaceholder.typicode.com
    ${response}=      DELETE On Session    jsonplaceholder    /posts/1
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.status_code}