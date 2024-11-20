*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Robot Framework Homepage
    Open Browser    https://robotframework.org/    Chrome
    Title Should Be    Robot Framework
    [Teardown]    Close Browser