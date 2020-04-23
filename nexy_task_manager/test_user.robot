*** Settings ***
Documentation    Selenium Example
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Test Cases ***
Make New Empty User
    [Documentation]    Создать пользователя без ввода имени
    [Tags]    create user
    [Setup]    Open Browser To Surf
    Create User    \
    Alert Should Be Present
    Sleep For A While
    [Teardown]    Close Browser

Make New User With Name
    [Documentation]    Создать нескольких пользователей c вводом имени
    [Tags]    create user
    [Setup]    Open Browser To Surf
    : FOR    ${INDEX}    IN RANGE    1    5
        \    ${random}    Generate Random String    25    [LETTERS]
        \    Create User    ${random}
    Page Should Contain    has been created
    Sleep For A While
    [Teardown]    Close Browser

Make New User With Quote Name
    [Documentation]    Создать пользователя c вводом имени в кавычках
    [Tags]    create user
    [Setup]    Open Browser To Surf
    Create User    "TEST"
    Page Should Contain    has been created
    Sleep For A While
    [Teardown]    Close Browser

Make Two Users With Same Name
    [Documentation]    Создать двух пользователей с одинаковым именем
    [Tags]    create user
    [Setup]    Open Browser To Surf
    Create User    twin
    Create User    twin
    Page Should Contain    has been created
    Sleep For A While
    [Teardown]    Close Browser

*** Keywords ***
