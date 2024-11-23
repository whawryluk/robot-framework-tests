*** Settings ***
Library           SeleniumLibrary
Variables         ../resources/variables.robot

*** Test Cases ***
Valid Login
    Open Browser    ${BASE_URL}    chrome
    Input Text      id=user-name    ${VALID_USERNAME}
    Input Text      id=password     ${VALID_PASSWORD}
    Click Button    id=login-button
    Wait Until Element Is Visible    xpath=//span[text()="Products"]
    Capture Page Screenshot
    [Teardown]    Close Browser

Invalid Login
    Open Browser    ${BASE_URL}    chrome
    Input Text      id=user-name    invalid_user
    Input Text      id=password     invalid_password
    Click Button    id=login-button
    Element Should Be Visible    xpath=//h3[contains(text(),"Epic sadface")]
    [Teardown]    Close Browser
