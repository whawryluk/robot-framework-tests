*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    https://robotframework.org/
${BROWSER}    Chrome
${OPTIONS}    headless

*** Test Cases ***
Open Robot Framework Homepage
    Open Browser    ${BASE_URL}    Chrome
    Title Should Be    Robot Framework
    [Teardown]    Close Browser

Verify Page URL
    [Setup]    Open Browser    https://robotframework.org    ${BROWSER}    options=--${OPTIONS}
    Location Should Be    ${BASE_URL}
    [Teardown]    Close Browser
