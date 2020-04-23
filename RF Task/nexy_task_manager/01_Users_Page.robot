*** Settings ***
Documentation    Test users page of nexy task manager
Resource     .${/}resource.robot

***Test Cases***
Check Title
    [Documentation]     Check title on users page
    [Tags]    user  title
    Open Users Page
    ${title}    Get Text    ${Title Text}
    Run Keyword If  '${title}' == 'Users'    log    Correct title
    ...    ELSE    Fail    Wrong title
    [Teardown]    Close Browser

Create New User
    [Documentation]     Test ability to create new user
    [Tags]    user
    Open Users Page
    Click Element   ${Create Page}
    Input Text      name:user_name    ${user}
    Click Element   ${Create Button}
    sleep    1 seconds
    Page Should Contain   User has been created
    [Teardown]  Close Browser

Create User With Existing User Name
    [Documentation]     Test ability to create new user with existing user name
    [Tags]    user
    Open Users Page
    Click Element   ${Create Page}
    Input Text      name:user_name    ${user}
    Click Element   ${Create Button}
    sleep    1 seconds
    Page Should Not Contain   User has been created
    [Teardown]  Close Browser

Create User With Empty name
    [Documentation]     Test if it's possible to create new user with empty username field
    [Tags]    user  empty
    Open Users Page
    Click Element   ${Create Page}
    Input Text      name:user_name    ${EMPTY}
    Click Element   ${Create Button}
    sleep    1 seconds
    ${alert message}    Handle Alert
    Should Be Equal As Strings  ${alert message}    Please fill user name
    Page Should Not Contain   User has been created
    [Teardown]  Close Browser