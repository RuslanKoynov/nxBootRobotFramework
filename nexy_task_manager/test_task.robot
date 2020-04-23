*** Settings ***
Documentation    Selenium Example
Force Tags    seleniumlibrary
Default Tags    example
Resource    resource.robot

*** Test Cases ***

Make New Task
    [Documentation]    Создать задачу с вводом значений удовлетворяющих требованиям
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Contain    has been created
    [Teardown]    Close Browser

#работа с полем name
Make New Task Without Name
    [Documentation]    Создать задачу без ввода имени (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    \    ${desc}    ${StartDate}    ${EndDate}    'user'
    Alert Should Be Present
    [Teardown]    Close Browser

Make New Task With A Long Name
    [Documentation]    Создать задачу с вводом имени больше 250 (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    251    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Not Contain    has been created
    [Teardown]    Close Browser

#работа с полем description
Make New Task Without Description
    [Documentation]    Создать задачу без ввода описания (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    \    ${StartDate}    ${EndDate}    'user'
    Alert Should Be Present
    [Teardown]    Close Browser

Make New Task With A Long Description
    [Documentation]    Создать задачу с вводом описания больше 1000 (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    1001    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Not Contain    has been created
    [Teardown]    Close Browser

#работа с полем assignee
Make New Task Without Assignee
    [Documentation]    Создать задачу без выбора пользователя (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    \
    Alert Should Be Present
    [Teardown]    Close Browser


#работа с датами
Make New Task Without Start Date
    [Documentation]    Создать задачу без ввода начальной даты (ожидается, что дата автоматически проставится как текущая)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    \    ${EndDate}    'user'
    Page Should Contain    has been created
    [Teardown]    Close Browser

Make New Task With Start Date Before Current
    [Documentation]    Создать задачу с начальной датой до текущей (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${CurrentDate}    Get Current Date
    ${NewDate}    Subtract Time From Date    ${CurrentDate}    1 day
    ${StartDate}    Convert Date    ${NewDate}    result_format=%d-%m-%Y
    ${EndDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Not Contain    has been created
    [Teardown]    Close Browser

Make New Task With End Date Before Current
    [Documentation]    Создать задачу с конечной датой до текущей (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${CurrentDate}    Get Current Date
    ${TmpDate}    Subtract Time From Date    ${CurrentDate}    1 day
    ${EndDate}    Convert Date    ${TmpDate}    result_format=%d-%m-%Y
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Not Contain    has been created
    [Teardown]    Close Browser

Make New Task With End Date Before Start Date
    [Documentation]    Создать задачу с вводом конечной даты до начальной (условие не соответствует требованиям, задача не должна быть создана)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${CurrentDate}    Get Current Date
    ${TmpDateS}    Add Time To Date    ${CurrentDate}    2 days
    ${TmpDateE}    Subtract Time From Date    ${TmpDateS}    1 day
    ${StartDate}    Convert Date    ${TmpDateS}    result_format=%d-%m-%Y
    ${EndDate}    Convert Date    ${TmpDateE}    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Page Should Not Contain    has been created
    [Teardown]    Close Browser

Make New Task Without End Date
    [Documentation]    Создать задачу без ввода конечной даты (ожидается, что конечная дата проставится как начальная дата + 2 дня)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Create User    user
    ${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${StartDate}    Get Current Date    result_format=%d-%m-%Y
    Create Task    ${name}    ${desc}    ${StartDate}    \    'user'
    Page Should Contain    has been created
    [Teardown]    Close Browser

Make Task At The Beginning Of February
    [Documentation]    Создать задачу с датой начала в начале февраля (ожидается, что к конечной дате прибавится 7 дней)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    01
    ${eday}    Set Variable    02
    ${edayExp}    Set Variable    09
    ${month}    Set Variable    02
    ${monthExp}    Set Variable    02
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

Make Task At The End Of February
    [Documentation]    Создать задачу с датой начала в конце февраля (ожидается, что к конечной дате прибавится 7 дней)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    27
    ${eday}    Set Variable    28
    ${edayExp}    Set Variable    07
    ${month}    Set Variable    02
    ${monthExp}    Set Variable    03
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

Make Task At The Beginning Of May
    [Documentation]    Создать задачу с датой начала в начале мая (ожидается, что к конечной дате прибавится 15 дней)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    01
    ${eday}    Set Variable    02
    ${edayExp}    Set Variable    17
    ${month}    Set Variable    05
    ${monthExp}    Set Variable    05
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

Make Task At The End Of May
    [Documentation]    Создать задачу с датой начала в конце мая (ожидается, что к конечной дате прибавится 15 дней)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    30
    ${eday}    Set Variable    31
    ${edayExp}    Set Variable    15
    ${month}    Set Variable    05
    ${monthExp}    Set Variable    06
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

Make Task In November
    [Documentation]    Создать задачу с датой начала в ноябре (ожидается, что конечной датой будет 31 декабря)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    15
    ${eday}    Set Variable    16
    ${edayExp}    Set Variable    31
    ${month}    Set Variable    11
    ${monthExp}    Set Variable    12
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

Make Task In December
    [Documentation]    Создать задачу с датой начала в декабре (ожидается, что конечной датой будет 31 декабря)
    [Tags]    create task
    [Setup]    Open Browser To Surf
    Sleep For A While
    Create User    user
    ${sday}    Set Variable    15
    ${eday}    Set Variable    16
    ${edayExp}    Set Variable    31
    ${month}    Set Variable    12
    ${monthExp}    Set Variable    12
    Make Task With Set Dates    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
    [Teardown]    Close Browser

*** Keywords ***
