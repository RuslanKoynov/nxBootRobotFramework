*** Settings ***
Documentation    Autotests
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Variables ***
${LOGIN URL}    http://localhost:3000/tasks
${BROWSER}    googlechrome

*** Test Cases ***

Create new task with existing user/Name less than 250 symbols and Description less than 1000 symbols
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, именем < 250 симв., описанием < 1000 симв. Ожидаем успешное создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Sleep    5 seconds
    [Teardown]    Close Browser


Create new task without Description
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, именем < 250 симв., без описания. Ожидаем ошибку при создании задачи без имени.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Alert Should Be Present    Please fill all form data
    Sleep    5 seconds
    [Teardown]    Close Browser
    Log    Couldn't create a task without Name field

Create new task with Description more than 1000 symbols
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, с именем < 250 симв., описанием > 1000 симв. Ожидаем ошибку при создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    1001    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Alert Should Be Present
    Sleep    5 seconds
    [Teardown]    Close Browser


Create new task with Description in quotes
    [Documentation]    Открыть браузер и создать новую задачу с имеющимся в системе пользователем, с именем < 250 символов, описанием < 1000 симв в кавычках. Ожидаем успешное создание задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    Input Text    name=task_name   ${random_name}
    Input Text    name=description    " "
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,"Chernousova Sophia")]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Sleep    5 seconds
    [Teardown]    Close Browser

*** Keywords ***
Open Browser to check
    Open Browser    ${LOGIN URL}    ${BROWSER}