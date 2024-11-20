*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    https://robotframework.org/
${BROWSER}    Chrome
${OPTIONS}    headless

*** Test Cases ***
Open Robot Framework Homepage
    [Setup]    Open Browser    https://robotframework.org    ${BROWSER}    options=add_argument("--${OPTIONS}")
    Title Should Be    Robot Framework
    [Teardown]    Close Browser

Verify Page URL
    [Setup]    Open Browser    https://robotframework.org    ${BROWSER}    options=add_argument("--${OPTIONS}")
    Location Should Be    ${BASE_URL}
    [Teardown]    Close Browser
