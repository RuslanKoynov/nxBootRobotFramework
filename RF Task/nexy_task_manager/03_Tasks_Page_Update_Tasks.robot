*** Settings ***
Documentation    Test editing on tasks page of nexy task manager
Resource     .${/}resource.robot

***Variables***
${Edit Button}    //*[contains(text(),'Edit')]
${Update Button}    //*[contains(text(),'Update')]
${Delete Button}    //*[contains(text(),'Delete')]

***Keywords***
Fill Task Status Field
    [Documentation]   Fills task status dropdown list with status with given index
    [Arguments]    ${index}
    

Change Status
    [Documentation]    Change status of task in dropdown list with status with given index
    [Arguments]    ${index}
    Open Tasks Page
    sleep   2 seconds
    Click Element  ${Edit Button}  
    Select From List By Index    name:task_status     ${index}
    Click Element  ${Update Button}
    sleep   2 seconds
    Page Should Contain    Task has been updated


***Test Cases***
Change Status To Expired
    [Documentation]    Check if it's possible to change task status to "Expired" 
    [Tags]    task  status
    Change Status  1
    [Teardown]    Close Browser

Change Status To In Progress
    [Documentation]    Check if it's possible to change task status to "In progress" 
    [Tags]    task  status
    Change Status  2
    [Teardown]    Close Browser

Change Status To Waiting
    [Documentation]    Check if it's possible to change task status to "Waiting" 
    [Tags]    task  status 
    Change Status  3
    [Teardown]    Close Browser

Change Status To Cancelled
    [Documentation]    Check if it's possible to change task status to "Cancelled" 
    [Tags]    task  status
    Change Status  4
    [Teardown]    Close Browser

Change Status To Closed
    [Documentation]    Check if it's possible to change task status to "Close" 
    [Tags]    task  status
    Change Status  5
    [Teardown]    Close Browser

Delete Task
    [Documentation]    Check if it's possible to delete task
    [Tags]    task  delete
    Open Tasks Page
    sleep   2 seconds
    Click Element   ${Delete Button}
    sleep   2 seconds
    Page Should Contain    Task has been deleted
    [Teardown]    Close Browser