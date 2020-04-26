*** Settings ***
Documentation     Проверка доступности основных элементов интерфейса
Resource          resource.robot

*** Variables ***
${browser}=     chrome
${url1}=        http://localhost:3000/tasks
${url2}=        http://localhost:3000/users


*** Test Cases ***

Task Window
    [Teardown]  Close Browser
    Open Browser Keyword  ${url1}    ${browser}
    Maximize Browser Window
    Element Visibility
    Tasks Title Visibility

User Window
    [Teardown]  Close Browser
    Open Browser Keyword  ${url2}    ${browser}
    Maximize Browser Window
    Element Visibility
    Users Title Visibility

Task Window Size Adaptability
    [Teardown]  Close Browser
    Open Browser Keyword  ${url1}    ${browser}
    Set Window Size   600  600
    sleep    2
    Element Visibility

User Window Size Adaptability
    [Teardown]  Close Browser
    Open Browser Keyword  ${url2}    ${browser}
    Set Window Size   600  600
    sleep    2
    Element Visibility

Go To User Creation Page
    [Teardown]  Close Browser
    Open Browser Keyword  ${url2}    ${browser}
    Maximize Browser Window
    Click Element    class:btn
    ${names}=   Get Location
    should be equal   ${names}    http://localhost:3000/users/create

Go To Task Creation Page
    [Teardown]  Close Browser
    Open Browser Keyword  ${url1}    ${browser}
    Maximize Browser Window
    Click Element    class:btn
    ${names}=   Get Location
    should be equal   ${names}    http://localhost:3000/tasks/create

Create User Window
    [Teardown]  Close Browser
    Open Browser Keyword  http://localhost:3000/users/create    ${browser}
    Maximize Browser Window
    Element Visibility
    ${title}=         Get WebElement    tag:h2
    Element Should Be Visible  ${title}
    Element Text Should Be     ${title}   Create user

Create Task Window
    [Teardown]  Close Browser
    Open Browser Keyword  http://localhost:3000/tasks/create    ${browser}
    Maximize Browser Window
    Element Visibility
    ${title}=         Get WebElement    tag:h2
    Element Should Be Visible  ${title}
    Element Text Should Be     ${title}   Create task


*** Keywords ***
Open Browser Keyword
    [Arguments]   ${arg1}   ${arg2}
    Open Browser    ${arg1}    ${arg2}


Element Visibility
    Header
    Task Link
    User Link
    Button








