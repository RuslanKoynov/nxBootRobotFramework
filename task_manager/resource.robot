*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String

*** Variables ***
${user_name}   Иван
${task_name}   task one
${task_description}  this is task one
${start_date}   03.09.2020
${end_date}     03.12.2020
${label}        1

*** Keywords ***

User Registration Keyword
    [Arguments]     ${name}
    [Tags]          user  registration
    Maximize Browser Window
    Input Text       name:user_name    ${name}
    Click Element    class:btn

Tasks Registration Keyword
    [Arguments]     ${name}  ${description}  ${start}  ${end}  ${label}
    Maximize Browser Window
    Input Text      name:task_name    ${name}
    Input Text      name:description  ${description}
    Input Text      name:start_date   ${start}
    Input Text      name:end_date     ${end}
    Select From List By Index   name:assignee  ${label}
    Click Element    class:btn

Header
    Title Should Be   Task Manager Tool

Tasks Title Visibility
    ${title}=         Get WebElement    tag:h2
    Element Should Be Visible  tag:h2
    Element Text Should Be     ${title}   Tasks

Users Title Visibility
    ${title}=         Get WebElement    tag:h2
    Element Should Be Visible  ${title}
    Element Text Should Be     ${title}   Users

Task Link
     ${link}=   Get WebElement  xpath://*[@id="root"]/div/div/nav/div/ul/li[1]/a
     Element Should Be Visible  ${link}
     Element Should Be Enabled  ${link}
     Element Text Should Be     ${link}   Tasks

User Link
     ${link}=   Get WebElement  xpath://*[@id="root"]/div/div/nav/div/ul/li[2]/a
     Element Should Be Visible  ${link}
     Element Should Be Enabled  ${link}
     Element Text Should Be     ${link}   Users

Button
    ${link}=   Get WebElement  class:btn
    Element Should Be Visible  ${link}
    Element Should Be Enabled  ${link}
    Element Text Should Be     ${link}   Create



