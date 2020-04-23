*** Settings ***
Documentation    Test tasks page of nexy task manager
Resource     .${/}resource.robot

***Variables***

***Keywords***
Fill Task Name
    [Arguments]    ${name}
    Input Text    name:task_name    ${name}
Fill Description
    [Arguments]    ${description}
    Input Text    name:description    ${description}
Fill Start Date
    [Arguments]    ${start date}
    Input Text     name:start_date    ${start date}
Fill End Date
    [Arguments]    ${end date}
    Input Text     name:end_date    ${end date}

Create Task
    [Documentation]    Create new task with given arguments
    [Arguments]  ${task name}  ${task description}  ${start date}  ${end date}  ${assignee}
    Open Tasks Page
    Click Element   ${Create Page}
    Fill Task Name  ${task name}
    Fill Description  ${task description}
    Fill Start Date  ${start date}
    Fill End Date  ${end date}
    Select From List By Index    name:assignee     ${assignee}
    Page Should Contain   ${user}
    Click Element    ${Create Button}

Generate String
    [Documentation]    Generate random string of given length
    [Arguments]    ${number}
    ${generated}  Generate Random String   ${number}   [LOWER]
    [Return]    ${generated}

Get Date Today
    [Documentation]    Get current date
    ${today}=  Get Current Date   result_format=%d-%m-%Y
    [Return]    ${today}

Get Date Tomorrow
    [Documentation]    Get tomorrow date
    ${today}=  Get Current Date
    ${tomorrow}=     Add Time To Date  ${today}  1day  result_format=%d-%m-%Y
    [Return]    ${tomorrow}

Get Date Yesterday
    [Documentation]    Get date of yesterday
    ${today}=   Get Current Date
    ${yesterday}=     Subtract Time From Date  ${today}  1day  result_format=%d-%m-%Y
    [Return]    ${yesterday}  

***Test Cases***
Check Tasks Page Title
    [Documentation]    Check title of tasks page
    [Tags]    tasks  title
    Open Tasks Page
    ${title}    Get Text    ${Title Text}
    Run Keyword If  '${title}' == 'Tasks'    log    Correct title
    ...    ELSE    Fail    Wrong title
    [Teardown]    Close Browser

Create New Task
    [Documentation]    Check ability to create new task
    [Tags]    tasks  create
    ${start_date}    Get Date Today
    ${end_date}  Get Date Tomorrow
    Create Task  Test  Automated Test  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    [Teardown]    Close Browser


Create New Task With Empty Task Name
    [Documentation]    Check ability to create new task with empty task name
    [Tags]    tasks  create  empty
    ${start_date}    Get Date Today
    ${end_date}  Get Date Tomorrow
    Create Task  ${Empty}  Automated Test  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Handle Alert
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With Empty Description
    [Documentation]    Check ability to create new task with empty description
    [Tags]    tasks  create  empty
    ${start_date}    Get Date Today
    ${end_date}  Get Date Tomorrow
    Create Task  Test  ${Empty}  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Handle Alert
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With Name Over 250 Symbols
    [Documentation]    Check ability to create new task with name over 250 symbols
    [Tags]    tasks  create  name
    ${name}    Generate String    ${251}
    ${start_date}    Get Date Today
    ${end_date}  Get Date Tomorrow
    Create Task  ${name}  Automated Test  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With Description Over 1000 Symbols
    [Documentation]    Check ability to create new task with description over 1000 symbols
    [Tags]    tasks  create  description
    ${description}    Generate String    ${1001}
    ${start_date}    Get Date Today
    ${end_date}  Get Date Tomorrow
    Create Task  Test  ${description}  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With Start Date Before Today
    [Documentation]    Check ability to create new task with start date earlier than today
    [Tags]    tasks  create  date
    ${start_date}    Get Date Yesterday
    ${end_date}  Get Date Tomorrow
    Create Task  Test  Automated Test  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With End Date Before Start Date
    [Documentation]    Check ability to create new task with end date earlier than start date
    [Tags]    tasks  create  date
    ${start_date}    Get Date Today
    ${end_date}   Get Date Yesterday
    Create Task  Test  Automated Test  ${start_date}  ${end_date}  1
    Sleep    2 seconds
    Page Should Not Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With No Start Date
    [Documentation]    Check ability to create new task with empty start date
    [Tags]    tasks  create  date
    ${end_date}    Get Date Tomorrow
    Create Task  Test  Automated Test  ${Empty}  ${end_date}  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    [Teardown]    Close Browser

Create New Task With No End Date
    [Documentation]    Check ability to create new task with empty end date
    [Tags]    tasks  create  date
    ${start_date}    Get Date Today
    Create Task  Test  Automated Test  ${start_date}  ${Empty}  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    [Teardown]    Close Browser

Create New Task Start Date February
    [Documentation]    Check if task with start date in february has end date + 7 days
    [Tags]    tasks  create  date  february
    Create Task  Test  Automated Test  10-02-2021  12-02-2021  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    Go To   ${tasks page url}
    Sleep    2 seconds 
    ${date february}    Get text    xpath=//*[@id="root"]/div/div/main/div/div[2]/div[4]/div/p[4]
    Should Be Equal As Strings    2021-02-10 - 2021-02-19   ${date february}
    [Teardown]    Close Browser

Create New Task Start Date November
    [Documentation]    Check if task with start date in november has end on 31 of december
    [Tags]    tasks  create  date  november
    Create Task  Test  Automated Test  10-11-2021  13-11-2021  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    Go To   ${tasks page url}
    Sleep    2 seconds
    ${date february}    Get text    xpath=//*[@id="root"]/div/div/main/div/div[2]/div[5]/div/p[4]
    Should Be Equal As Strings    2021-11-10 - 2021-12-31   ${date february}
    [Teardown]    Close Browser

Create New Task Start Date December
    [Documentation]    Check if task with start date in december has end on 31 of decembe
    [Tags]    tasks  create  date  december
    Create Task  Test  Automated Test  10-12-2021  12-12-2021  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    Go To   ${tasks page url}
    Sleep    2 seconds
    ${date february}    Get text    xpath=//*[@id="root"]/div/div/main/div/div[2]/div[6]/div/p[4]
    Should Be Equal As Strings    2021-12-10 - 2021-12-31   ${date february}
    [Teardown]    Close Browser

Create New Task Start Date May
    [Documentation]    Check if task with start date in May has end date +15 days
    [Tags]    tasks  create  date  may
    Create Task  Test  Automated Test  10-05-2021  12-05-2021  1
    Sleep    2 seconds
    Page Should Contain   Task has been created
    Go To   ${tasks page url}
    Sleep    2 seconds
    ${date february}    Get text    xpath=//*[@id="root"]/div/div/main/div/div[2]/div[7]/div/p[4]
    Should Be Equal As Strings    2021-05-10 - 2021-05-25   ${date february}
    [Teardown]    Close Browser

Create New Task Without Assignee
    [Documentation]    Check if task without assignee has status "created"
    [Tags]    tasks  create  created  assignee
    ${start_date}    Get Date Today
    ${end_date}   Get Date Tomorrow
    Create Task  Test  Automated Test  ${start_date}  ${end_date}  0
    Sleep    2 seconds
    Page Should Contain   Task has been created
    Go To   ${tasks page url}
    Sleep    2 seconds
    ${assignee}    Get text    xpath=//*[@id="root"]/div/div/main/div/div[2]/div[8]/div/p[4]
    Should Be Equal As Strings    Created   ${assignee}
    [Teardown]    Close Browser