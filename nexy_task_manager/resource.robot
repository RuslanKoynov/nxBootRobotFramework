*** Settings ***
Library    OperatingSystem
Library    Collections
Library    BuiltIn
Library    String
Library    Selenium2Library
Library    Screenshot
Library    RequestsLibrary
Library    DateTime
#Process
#Screenshot
#String
#Telnet
#XML

*** Variables ***
${NAME}             Robot Framework
${VERSION}          2.0
${ROBOT}            ${NAME} ${VERSION}  #catenate 2 or more variables
${USER}             Rezeda
@{NUMBERS}    0   1   2   3   4   5   6   7   8   9
@{LETTER_NUMBERS}   zero   one   two  three   four    five   six   seven   eight   nine
${test_user}    user
${URL}    http://localhost:3000
${BROWSER}    googlechrome

*** Keywords ***

Open Browser To Surf
    Open Browser    ${URL}    ${BROWSER}

Sleep For A While
    Sleep    4 seconds

Create User
    [Documentation]   Создает пользователя
	[Tags]   create user
	[Arguments]   ${name}
    Click Link    xpath=//a[contains(.,"Users")]
    Click Link    xpath=//a[contains(.,"Create")]
    Input Text    name=user_name    ${name}
    Sleep For A While
    Click Element    xpath=//button[contains(.,"Create")]
    Sleep For A While

Create Task
    [Documentation]   Создает задачу
	[Tags]   create task
	[Arguments]   ${name}    ${desc}    ${start_date}    ${end_date}    ${assignee}
    Go To    http://localhost:3000/tasks
    Click Link    xpath=//a[contains(.,"Create")]
    Input Text    name=task_name    ${name}
    Input Text    name=description    ${desc}
    Input Text    name=start_date    ${start_date}
    Input Text    name=end_date    ${end_date}
    Run Keyword Unless    "${assignee}"=="\"    Click Element    name=assignee
    Sleep For A While
    Run Keyword Unless    "${assignee}"=="\"    Click Element    xpath=//select[@name="assignee"]/option[contains(.,${assignee})]
    Click Element    xpath=//button[contains(.,"Create")]
    Sleep For A While

Set Date For Count
    [Documentation]   Перевести промежуток в формат начало - конец (год-месяц-день) следующего года
	[Tags]   convert date
	[Arguments]   ${sDay}    ${eDay}    ${month}    ${monthExp}
	${CurrentDate}    Get Current Date
    ${TmpDate}    Add Time To Date    ${CurrentDate}    365 days
    ${year}    Convert Date    ${TmpDate}    result_format=%Y
    ${TempDate}    Evaluate    '${year}-${month}-${sDay} - ${year}-${monthExp}-${eDay}'
    [Return]    ${TempDate}

Set Date For Input
    [Documentation]   Перевести в формат день-месяц-год (этот, если число - 1 или 2 января)
	[Tags]   convert date
	[Arguments]   ${setDay}    ${month}
	${CurrentDate}    Get Current Date
    ${TmpDate}    Add Time To Date    ${CurrentDate}    365 days
    ${TmpYear}    Convert Date    ${TmpDate}    result_format=%Y
    ${TmpDay}    Set Variable    ${setDay}
    ${TmpMonth}    Set Variable    ${month}
    ${TempDate}    Evaluate    '${TmpDay}${TmpMonth}${TmpYear}'
    [Return]    ${TempDate}

Count Diff
    [Documentation]   Рассчитать разницу количества задач с указанными датами
	[Tags]   count
	[Arguments]   ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}    ${name}    ${desc}
	${StartDate}    Set Date For Input    ${sday}    ${month}
    ${EndDate}    Set Date For Input    ${eday}    ${month}
    ${TempDate}    Set Date For Count    ${sday}    ${edayExp}    ${month}    ${monthExp}
    Go To    http://localhost:3000/tasks
    Sleep For A While
    ${countBefore} =  Get Element Count   xpath=//p[contains(.,'${TempDate}')]
    Create Task    ${name}    ${desc}    ${StartDate}    ${EndDate}    'user'
    Go To    http://localhost:3000/tasks
    Sleep For A While
    ${countAfter} =  Get Element Count   xpath=//p[contains(.,'${TempDate}')]
    ${diff}    Evaluate    ${countAfter}-${countBefore}
    [Return]    ${diff}

Make Task With Set Dates
    [Documentation]   Рассчитать разницу количества задач с указанными датами
	[Tags]   create task
	[Arguments]   ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}
	${name}    Generate Random String    25    [LETTERS]
    ${desc}    Generate Random String    25    [LETTERS]
    ${wrongDate}    Set Date For Count    ${sday}    ${eday}    ${month}    ${month}
    ${countDiff}    Count Diff    ${sday}    ${eday}    ${edayExp}    ${month}    ${monthExp}    ${name}    ${desc}
    ${countWrong} =  Get Element Count   xpath=//p[contains(.,'${wrongDate}')]
    should be equal as integers    ${countWrong}    ${0}
    should be equal as integers    ${countDiff}    ${1}