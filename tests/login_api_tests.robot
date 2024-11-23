*** Settings ***
Library           RequestsLibrary
Variables         ../resources/variables.robot

*** Test Cases ***
Login API Test
    Create Session    swag    ${BASE_URL}
    ${response}=    Post Request    swag    /login    data={"username": "${VALID_USERNAME}", "password": "${VALID_PASSWORD}"}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.json()}
