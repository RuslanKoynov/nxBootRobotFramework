*** Settings ***
Documentation    TasksManagerTest
Resource    .${/}Resource.robot


*** Test Case ***

Update Tasks Name
    [Documentation]    Update Tasks Name
    [Tags]    Tasks, Update
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK_UPDATE_BUTTON}
    Input Tasks name    Update Tasks Name
    Click Element    ${CREATE_TASK_BUTTON}
    sleep   4 second
    Page Should Contain     Task has been updated
    [Teardown]    Close browser

Update Tasks Description
    [Documentation]    Update Tasks Description
    [Tags]    Tasks, Update
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK_UPDATE_BUTTON}
    Input Description Update name     Update Tasks Description
    Click Element    ${CREATE_TASK_BUTTON}
    sleep   4 second
    Page Should Contain     Task has been updated
    [Teardown]    Close browser

Update Tasks Start Date
    [Documentation]    Update Tasks Start Date
    [Tags]    Tasks, Update
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK_UPDATE_BUTTON}
    Click Element    ${TASK_UPDATE_DATESTART_BUTTON}
    Input Date Update start    20200430
    Click Element    ${CREATE_TASK_BUTTON}
    sleep   4 second
    Page Should Contain     Task has been updated
    [Teardown]    Close browser

Verify Task Update Start Date
     [Documentation]    Verify Task Update Start Date
     [Tags]    Tasks, Verify
     Open Tasks Page
     sleep     2 second
     ${value_tasks_update_start_date}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_update_start_date}' == '2020-04-30 - 2020-05-14'     log    Success!
     Run Keyword Unless    '${value_tasks_update_start_date}' == '2020-04-30 - 2020-05-14'    Fail    Value did not match!
     [Teardown]    Close Browser

Update Tasks End Date
    [Documentation]     Update Tasks End Date
    [Tags]    Tasks, Update
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK_UPDATE_BUTTON}
    Click Element    ${TASK_UPDATE_DATEEND_BUTTON}
    Input Date Update end  20200526
    Click Element    ${CREATE_TASK_BUTTON}
    sleep   4 second
    Page Should Contain     Task has been updated
    [Teardown]    Close browser

Verify Task Update End Date
     [Documentation]     Verify Task Update End Date
     [Tags]    Tasks, Verify
     Open Tasks Page
     sleep     2 second
     ${value_tasks_update_start_date}    Get text    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > p:nth-child(3)
     Run Keyword If    '${value_tasks_update_start_date}' == '2020-04-30 - 2020-05-26'     log    Success!
     Run Keyword Unless    '${value_tasks_update_start_date}' == '2020-04-30 - 2020-05-26'    Fail    Value did not match!
     [Teardown]    Close Browser

Update Tasks Assigne
    [Documentation]     1-ASSIGNED 2-EXPIRED 3-IN PROGRESS 4-WAITING 5-CANSELLED 6-CLOSED
    [Tags]    Tasks, Update
    Open Tasks Page
    sleep    2 seconds
    Click Element    ${TASK_UPDATE_BUTTON}
    ${result}=    Select Assign Update    4
    Click Element    ${result}
    sleep    2 seconds
    Click Element    ${CREATE_TASK_BUTTON}
    sleep   2 second
    Page Should Contain     Task has been updated
    [Teardown]    Close browser

Delete Tasks
    [Documentation]    Delete task
    [Tags]    task, delete
    Open Tasks Page
    sleep    2 seconds
    : FOR    ${task}  IN  @{tasks}
    \    Click Element    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > div > button:nth-child(2)
    \    sleep    2 second
    \    Reload page
    Log    Complete!
    [Teardown]    Close browser
