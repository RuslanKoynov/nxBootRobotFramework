*** Settings ***
Documentation     Примеры регистрации задачи с различными вариантами заполнения названия.
Resource          resource.robot
Suite Setup       Open Browser     http://localhost:3000/tasks/create   chrome
Suite Teardown    Close Browser

#задать параметры для регистрации задачи и вставлять из в тест по мере необходимости
#зарегать пользователя

*** Test Cases ***

Register Task With Valid Data
    Tasks Registration Keyword   ${task_name}  ${task_description}  ${start_date}  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created


Register Task With Empty Fields
    Click Element    class:btn
    sleep   1
    Alert Should Be Present   Please fill all form data


Register Task With More Than 250 Symbols In Name
    Tasks Registration Keyword   Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex  ${task_description}   ${start_date}   ${end_date}   ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created

Register Task With Empty Name
    Tasks Registration Keyword    ${empty}  ${task_description}  ${start_date}  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created

Register Task With Space Name
    Tasks Registration Keyword    ${space}  ${task_description}  ${start_date}  ${end_date}  ${label}
    sleep   1
    Alert Should Be Present   Please fill all form data


