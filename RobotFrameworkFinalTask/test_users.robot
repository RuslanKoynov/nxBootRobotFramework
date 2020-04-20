*** Settings ***
Documentation    Test task manager   #description of test case
Resource     .${/}resource.robot


*** Test Cases ***
Open User Page And Check Title
    [Documentation]  Check User
    [Tags]    user, check
    Open Users Page
    ${value}    Get text    ${USERS_TITLE}
    Run Keyword If    '${value}' == 'Users'     log    Success!
    Run Keyword Unless    '${value}' == 'Users'    Fail    Value did not match!
    [Teardown]    Close Browser

Create User
    [Documentation]  Create User
    [Tags]    user, create
    Open Users Page
    Click Element    ${USER_CREATE_BUTTON}
    Input Username    Evgeniy
    Click Element    ${CREATE_FORM_USER_BUTTON}
    sleep    1 seconds
    Page Should Contain   User has been created
    [Teardown]    Close browser


Create User Empty
    [Documentation]  Create User with empty name
    [Tags]    user, create
    Open Users Page
    Click Element    ${USER_CREATE_BUTTON}
    Input Username    ${EMPTY}
    Click Element    ${CREATE_FORM_USER_BUTTON}
    ${message alert}=   Handle Alert
    Page Should Not Contain    User has been created
    [Teardown]    Close browser

