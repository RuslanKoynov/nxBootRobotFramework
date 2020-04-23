*** Settings ***
Documentation    Autotests
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Variables ***
${LOGIN URL}    http://localhost:3000/tasks
${BROWSER}    googlechrome

*** Test Cases ***
Browser
    [Documentation]    Открыть браузер
    [Tags]    open browser
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Take Screenshot
    [Teardown]    Close Browser

Create New User with Name
    [Documentation]    Открыть браузер и создать нового пользователя c любым именем
    [Tags]    create user
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Users")]
    Click Link    xpath=//a[contains(.,"Create")]
    Input Text    name=user_name    ${USER}
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    User has been created
    Sleep    5 seconds
    [Teardown]    Close Browser

Create New User with Long Name
    [Documentation]    Открыть браузер и создать нового пользователя с длинным именем
    [Tags]    create long user
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Users")]
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    1000    [LETTERS]
    Input Text    name=user_name    ${random_name}
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    User has been created
    Sleep    5 seconds
    [Teardown]    Close Browser

Create New User with name in quotes
    [Documentation]    Открыть браузер и создать нового пользователя с именем в двойных кавычках
    [Tags]    create empty user
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Users")]
    Click Link    xpath=//a[contains(.,"Create")]
    Input Text    name=user_name    " "
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Request failed
    Sleep    5 seconds
    [Teardown]    Close Browser

Create New User without Name
    [Documentation]    Открыть браузер и создать нового пользователя без поля Name
    [Tags]    create user without Name
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Users")]
    Click Link    xpath=//a[contains(.,"Create")]
    Click Element    xpath=//button[contains(.,"Create")]
    Alert Should Be Present    Please fill user name
    Sleep    5 seconds
    [Teardown]    Close Browser
    Log    Couldn't create a user without Name field  

*** Keywords ***
Open Browser to check
    Open Browser    ${LOGIN URL}    ${BROWSER}