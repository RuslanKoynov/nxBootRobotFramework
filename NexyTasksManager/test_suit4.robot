*** Settings ***
Documentation    Autotests
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Variables ***
${LOGIN URL}    http://localhost:3000/tasks
${BROWSER}    googlechrome

*** Test Cases ***

Create new task with start_date = current date
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
 
 
Create new task with start_date earlier than current date
    [Documentation]    Открыть браузер и создать новую задачу с датой начала раньше, чем текущая дата. Ожидаем ошибку при создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}    Subtract Time From Date    ${CurrentDate}    1 day
    ${StartDate}    Convert Date    ${NewDate}    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}у
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Request failed
    Sleep    5 seconds
    [Teardown]    Close Browser
 
Create new task with start_date later than current date
    [Documentation]    Открыть браузер и создать новую задачу c датой начала позже, чем текущая дата. Ожидаем, что задача будет успешно создана.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}    Add Time To Date    ${CurrentDate}    1 day
    ${StartDate}    Convert Date    ${NewDate}    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${NewDate}    Add Time To Date    ${CurrentDate}    2 days
    ${EndDate}    Convert Date    ${NewDate}    result_format=%d-%m-%Y
    Input Text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Sleep    5 seconds
    [Teardown]    Close Browser
 
 
Create new task with start_date later than end_date
    [Documentation]    Открыть браузер и создать новую задачу с датой начала позже, чем дата завершения. Ожидаем ошибку при создании задачи.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${CurrentDate}    Get Current Date    result_format=%Y-%m-%d
    ${NewDate}    Add Time To Date    ${CurrentDate}    2 days
    ${StartDate}    Convert Date    ${NewDate}    result_format=%d-%m-%Y
    Input Text    name=start_date    ${StartDate}
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Input text    name=end_date    ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Request failed
    Sleep    5 seconds
    [Teardown]    Close Browser
 
Create new task with start_date in February
    [Documentation]    Открыть браузер и создать новую задачу с датой начала в феврале. Ожидаем, что к дате завершения добавится 7 дней.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    ${StartDay}    set variable    01
    ${EndDay}    set variable    02
    ${ResultEndDay}    set variable    09
    ${Month}    set variable    02
    ${SearchDate}    Convert in start end    ${StartDay}    ${ResultEndDay}    ${Month}
    ${CountBefore}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Convert in d.m.y    ${StartDay}    ${Month}
    ${EndDate}    Convert in d.m.y    ${EndDay}    ${Month}
    Input Text    name=start_date    ${StartDate}
    Input Text     name=end_date     ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Click Link    xpath=//a[contains(.,"Tasks")]
    ${CountAfter}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Should Be True    ${CountAfter}>${CountBefore}    
    Sleep    5 seconds
    [Teardown]    Close Browser
 
Create new task with start_date in December
    [Documentation]    Открыть браузер и создать новую задачу с датой начала в декабре. Ожидаем, что дата завершения станет 31 декабря.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    ${StartDay}    set variable    01
    ${EndDay}    set variable    02
    ${ResultEndDay}    set variable    31
    ${Month}    set variable    12
    ${SearchDate}    Convert in start end    ${StartDay}    ${ResultEndDay}    ${Month}
    ${CountBefore}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Convert in d.m.y    ${StartDay}    ${Month}
    ${EndDate}    Convert in d.m.y    ${EndDay}    ${Month}
    Input Text    name=start_date    ${StartDate}
    Input Text     name=end_date     ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Click Link    xpath=//a[contains(.,"Tasks")]
    ${CountAfter}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Should Be True    ${CountAfter}>${CountBefore}    
    Sleep    5 seconds
    [Teardown]    Close Browser
 
Create new task with start_date in November
    [Documentation]    Открыть браузер и создать новую задачу с датой начала в ноябре. Ожидаем, что дата завершения станет 31 декабря.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    ${StartDay}    set variable    01
    ${EndDay}    set variable    02
    ${ResultEndDay}    set variable    31
    ${Month}    set variable    11
    ${MonthResult}    set variable    12
    ${SearchDate}    Convert in start end    ${StartDay}    ${ResultEndDay}    ${MonthResult}
    ${RealDate}    Convert in start end    ${StartDay}    ${EndDay}    ${Month}
    ${CountBefore}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    ${CountDateBefore}    Get Element Count    xpath=//p[contains(.,'${RealDate}')]
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Convert in d.m.y    ${StartDay}    ${Month}
    ${EndDate}    Convert in d.m.y    ${EndDay}    ${Month}
    Input Text    name=start_date    ${StartDate}
    Input Text     name=end_date     ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Click Link    xpath=//a[contains(.,"Tasks")]
    ${CountAfter}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    ${CountDateAfter}    Get Element Count    xpath=//p[contains(.,'${RealDate}')]
    Should Be True    ${CountAfter} > ${CountBefore}
    Should Be True    ${CountDateBefore} > ${CountDateAfter}    
    Sleep    5 seconds
    [Teardown]    Close Browser

Create new task with start_date in May
    [Documentation]    Открыть браузер и создать новую задачу с датой начала в мае. Ожидаем, что к дате завершения добавится 15 дней.
    [Tags]    create task
    [Setup]    Open Browser to check
    Sleep    5 seconds
    ${StartDay}    set variable    01
    ${EndDay}    set variable    02
    ${ResultEndDay}    set variable    17
    ${Month}    set variable    05
    ${SearchDate}    Convert in start end    ${StartDay}    ${ResultEndDay}    ${Month}
    ${CountBefore}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Click Link    xpath=//a[contains(.,"Create")]
    ${random_name}    Generate Random String    249    [LETTERS]
    ${random_description}    Generate Random String    999    [LETTERS]
    Input Text    name=task_name    ${random_name}
    Input Text    name=description    ${random_description}
    ${StartDate}    Convert in d.m.y    ${StartDay}    ${Month}
    ${EndDate}    Convert in d.m.y    ${EndDay}    ${Month}
    Input Text    name=start_date    ${StartDate}
    Input Text     name=end_date     ${EndDate}
    Click Element    name=assignee
    Sleep    5 seconds
    Click Element    xpath=//select[@name="assignee"]/option[contains(.,'Chernousova Sophia')]
    Click Element    xpath=//button[contains(.,"Create")]
    Wait Until Page Contains    Task has been created
    Click Link    xpath=//a[contains(.,"Tasks")]
    ${CountAfter}    Get Element Count    xpath=//p[contains(.,'${SearchDate}')]
    Should Be True    ${CountAfter}>${CountBefore}    
    Sleep    5 seconds
    [Teardown]    Close Browser

*** Keywords ***
Open Browser to check
    Open Browser    ${LOGIN URL}    ${BROWSER}

Convert in start end
    [Documentation]    Переводит дату в формат StartDate-EndDate, формат самой даты - год-месяц-день
    [Tags]    converted date
    [Arguments]    ${StartDay}    ${EndDay}    ${Month}
    ${CurrentDate}    Get Current Date
    ${NewDate}    Add Time To Date    ${CurrentDate}    366 days
    ${Year}    Convert Date    ${NewDate}    result_format=%Y
    ${NewDate}    Evaluate    '${Year}-${Month}-${StartDay} - ${Year}-${Month}-${EndDay}'
    [Return]    ${NewDate}

Convert in d.m.y
    [Documentation]    Переводит заданную дату в формат день.месяц.год
    [Tags]    new date
    [Arguments]    ${Day_to_convert}    ${Month_to_convert}
    ${CurrentDate}    Get Current Date
    ${NewDate}    Add Time To Date    ${CurrentDate}    366 days
    ${Year}    Convert Date    ${NewDate}    result_format=%Y
    ${Day}    set variable    ${Day_to_convert}
    ${Month}    set variable    ${Month_to_convert}
    ${NewDate}    Evaluate    '${Day}${Month}${Year}'
    [Return]    ${NewDate}