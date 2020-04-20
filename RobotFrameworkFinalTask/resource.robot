*** Settings ***
Library    OperatingSystem    #used library
Library    Collections
Library    String
Library    Telnet
Library	   JsonValidator
Library    Process
Library    SeleniumLibrary

*** Variables ***
# Общие переменные
${USER}    Ilya Lyasin
${TASKS URL}      http://localhost:3000/tasks
${USERS URL}      http://localhost:3000/users
${BROWSER}        chrome

# Переменные для проверки USER
${USER_TITLE}    css:#root > div > div > main > div > div > h2
${USER_CREATE_BUTTON}    css:#root > div > div > main > div > div > div > a
${CREATE_FORM_USER_BUTTON}    css:#root > div > div > main > div > form > button

# Переменные для проверки TASK
${TASK_PAGE_TITLE}    css:#root > div > div > main > div > div.d-flex.justify-content-between.flex-wrap.flex-md-nowrap.align-items-center.pb-2.mb-3 > h2
${TASK_DELETE_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > div > button:nth-child(2)
${TASK_UPDATE_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > div > button:nth-child(1)
${CREATE_TASK_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > button
${TASK_UPDATE_DATESTART_BUTTON}    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(3) > div:nth-child(1) > input
${TASK_UPDATE_DATEEND_BUTTON}    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(3) > div:nth-child(2) > input
${SYMBOLS}    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
${SYMBOLS_1001 }   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
@{tasks}    1  2  3  4  5  6  7  8

# Переменные для формы добавления задачи
${TASK CREATE BUTTON}    css:#root > div > div > main > div > div.d-flex.justify-content-between.flex-wrap.flex-md-nowrap.align-items-center.pb-2.mb-3 > div > a
${START DATE FIELD}    css:#root > div > div > main > div > form > div:nth-child(3) > div:nth-child(1) > input
${END DATE FIELD}    css:#root > div > div > main > div > form > div:nth-child(3) > div:nth-child(2) > input
${CREATE FORM BUTTON}    css:#root > div > div > main > div > form > button



*** Keywords ***
Open Tasks Page
    Open Browser    ${TASKS URL}    ${BROWSER}

Open Users Page
    Open Browser    ${USERS URL}    ${BROWSER}

Input Username
    [Arguments]    ${username}
    Input Text    name:user_name    ${username}

Input Tasks Name
    [Arguments]    ${tasksname}
    Input text     name:task_name    ${tasksname}

Input Description Name
    [Arguments]    ${descriptionname}
    Input text     name:description    ${descriptionname}

Input Date Start
    [Arguments]    ${datastart}
    Input text     name:start_date    ${datastart}

Input Date End
    [Arguments]    ${datastart}
    Input text     name:end_date    ${datastart}

Select Assign
    [Arguments]    ${number}
    [Return]     css:#root > div > div > main > div > form > div:nth-child(4) > div > select > option:nth-child(${number})

Input Description Update Name
    [Arguments]    ${descriptionupdatename}
    Input text     name:task_description    ${descriptionupdatename}

Input Date Update Start
    [Arguments]    ${datastart}
    Input text     name:task_start_date    ${datastart}

Input Date Update End
    [Arguments]    ${datastart}
    Input text     name:task_end_date    ${datastart}

Select Assign Update
    [Arguments]    ${number_assigne}
    [Return]       css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(4) > div > select > option:nth-child(${number_assigne})