*** Settings ***
Documentation    Test task manager   #description of test case
Resource     .${/}resource.robot


*** Test Cases ***
Open Task Page And Check Title
    [Documentation]  Check Task
    [Tags]    task, check
    Open Tasks Page
    ${value}    Get text    ${TASK_PAGE_TITLE}
    Run Keyword If    '${value}' == 'Tasks'     log    Success!
    Run Keyword Unless    '${value}' == 'Tasks'    Fail    Value did not match!
    [Teardown]    Close Browser

Create Task
    [Documentation]  Check create task
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks name    Testing 1
    Input Description name    test alert 3
    Click Element    ${START DATE FIELD}
    Input Date start    21042020
    Click Element    ${END DATE FIELD}
    Input Date end    22042020
    ${assigned}=   Select Assign    3
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep    1 seconds
    Page Should Contain   Task has been created
    [Teardown]    Close browser


Create Empty Task
    [Documentation]    Create task with name = EMPTY
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    ${EMPTY}
    Input Description Name    empty
    Click Element    ${START DATE FIELD}
    Input Date Start    21042020
    Click Element    ${END DATE FIELD}
    Input Date End    22042020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep    1 seconds
    ${message alert}=   Handle Alert
    Page Should Not Contain   Task has been created
    [Teardown]    Close browser

Create Empty Description
    [Documentation]    Create task with empty description
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Empty Description
    Input Description Name    ${EMPTY}
    Click Element    ${START DATE FIELD}
    Input Date Start    21042020
    Click Element    ${END DATE FIELD}
    Input Date End    22042020
    ${assigned}=   Select Assign    2
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep    1 seconds
    ${message alert}=   Handle Alert
    Page Should Not Contain   Task has been created
    [Teardown]    Close browser

Create Tasks With Name Over 250 Symbols
    [Documentation]    Create task with name over 250 symbols
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name      ${SYMBOLS}
    Input Description Name    Testing 2
    Click Element    ${START DATE FIELD}
    Input Date Start    21042020
    Click Element    ${END DATE FIELD}
    Input Date End    22042020
    ${assigned}=   Select Assign    2
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep    1 second
    Page Should Not Contain   Task has been created
    [Teardown]    Close browser

Create Task With Description Over 1000 Symbols
    [Documentation]   Create task with description Over 1000 Symbols
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Testing 3
    Input Description Name    ${SYMBOLS_1001}
    Click Element    ${START DATE FIELD}
    Input Date Start    21042020
    Click Element    ${END DATE FIELD}
    Input Date End    22042020
    ${assigned}=   Select Assign    3
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep    1 second
    Page Should Not Contain   Task has been created
    [Teardown]    Close browser

Create Task November
    [Documentation]    Create task november date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Task November
    Input Description name    Testing 4
    Click Element    ${START DATE FIELD}
    Input Date start    01112020
    Click Element    ${END DATE FIELD}
    Input Date end    21112020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    Page Should Contain     Task has been created
    [Teardown]    Close Browser

Verify Task November End Date
     [Documentation]    check date
     [Tags]    task, check
     Open Tasks Page
     sleep     2 second
     ${value_tasks_november}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(4) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_november}' == '2020-11-01 - 2020-12-31'     log    Success!
     Run Keyword Unless    '${value_tasks_november}' == '2020-11-01 - 2020-12-31'    Fail    Value did not match!
     [Teardown]    Close Browser

Create Task December
    [Documentation]    Create task december date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Task December
    Input Description Name    Task December
    Click Element    ${START DATE FIELD}
    Input Date start    01122020
    Click Element    ${END DATE FIELD}
    Input Date End    21122020
    ${assigned}=   Select Assign    3
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    Page Should Contain     Task has been created
    [Teardown]    Close Browser

Verify Task December End Date
     [Documentation]    check date
     [Tags]    task, check
     Open Tasks Page
     sleep     2 second
     ${value_tasks_december}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(5) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_december}' == '2020-12-01 - 2020-12-31'     log    Success!
     Run Keyword Unless    '${value_tasks_december}' == '2020-12-01 - 2020-12-31'    Fail    Value did not match!
     [Teardown]    Close Browser

Create Task May
    [Documentation]    Create task May date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Task May
    Input Description Name    Task May
    Click Element    ${START DATE FIELD}
    Input Date Start    01052020
    Click Element    ${END DATE FIELD}
    Input Date End    21052020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    Page Should Contain     Task has been created
    [Teardown]    Close Browser

Verify Task May End Date
     [Documentation]    check date
     [Tags]    task, check
     Open Tasks Page
     sleep     2 second
     ${value_tasks_december}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(6) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_december}' == '2020-05-01 - 2020-06-05'     log    Success!
     Run Keyword Unless    '${value_tasks_december}' == '2020-05-01 - 2020-06-05'    Fail    Value did not match!
     [Teardown]    Close Browser

Create Task July
    [Documentation]    Create task July date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Task July
    Input Description Name    Task July
    Click Element    ${START DATE FIELD}
    Input Date Start    01072020
    Click Element    ${END DATE FIELD}
    Input Date End    21072020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    Page Should Contain     Task has been created
    [Teardown]    Close Browser

Verify Task July End Date
     [Documentation]    Create task with name over 250 symbols
     [Tags]    task, check
     Open Tasks Page
     sleep     2 second
     ${value_tasks_december}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(7) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_december}' == '2020-07-01 - 2020-07-21'     log    Success!
     Run Keyword Unless    '${value_tasks_december}' == '2020-07-01 - 2020-07-21'    Fail    Value did not match!
     [Teardown]    Close Browser

Create Task September
    [Documentation]    Create task september date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    Task September
    Input Description Name    Task September
    Click Element    ${START DATE FIELD}
    Input Date Start    01092020
    Click Element    ${END DATE FIELD}
    Input Date end    21092020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    Page Should Contain     Task has been created
    [Teardown]    Close Browser

Verify Task September End Date
     [Documentation]    check date
     [Tags]    task, check
     Open Tasks Page
     sleep     2 second
     ${value_tasks_december}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(8) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_december}' == '2020-09-01 - 2020-09-21'     log    Success!
     Run Keyword Unless    '${value_tasks_december}' == '2020-09-01 - 2020-09-21'    Fail    Value did not match!
     [Teardown]    Close Browser

Create Task Empty End Date
    [Documentation]    Create task without end date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    empty end date
    Input Description Name    test
    Click Element    ${START DATE FIELD}
    Input Date Start    21042020
    Click Element    ${END DATE FIELD}
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    ${message alert}=   Handle Alert
    Page Should Contain     Task has been created
    [Teardown]    Close browser

Create Task Empty Start Date
    [Documentation]    Create task without start date
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks Name    777
    Input Description Name    999
    Click Element    ${START DATE FIELD}
    Click Element    ${END DATE FIELD}
    Input Date End    21092020
    ${assigned}=   Select Assign    5
    Click Element    ${assigned}
    Click Element    ${CREATE FORM BUTTON}
    sleep   1 second
    ${message alert}=   Handle Alert
    Page Should Contain     Task has been created
    [Teardown]    Close browser

Create Task Empty Assigned
    [Documentation]    Create task without assignee
    [Tags]    task, create
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK CREATE BUTTON}
    Input Tasks name    TEST ASSIGNED
    Input Description name    TEST ASSIGNED
    Click Element    ${START DATE FIELD}
    Input Date start    01092020
    Click Element    ${END DATE FIELD}
    Input Date end    21092020
    sleep   1 second
    Click Element    ${CREATE FORM BUTTON}
    ${message alert}=   Handle Alert
    Page Should Contain     Task has been created
    [Teardown]    Close browser



