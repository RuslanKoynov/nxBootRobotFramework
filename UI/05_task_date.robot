*** Settings ***
Documentation    Проверка ввода данных даты начала и окончания задачи.
Resource          resource.robot
Suite Setup       Open Browser     http://localhost:3000/tasks/create   chrome
Suite Teardown    Close Browser


*** Test Cases ***


Empty Start Date
    Tasks Registration Keyword   ${task_name}  ${task_description}  ${empty}  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created


Invalid Date
    Tasks Registration Keyword   ${task_name}  ${task_description}  51.40.2020  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created

Start Date Before Current Date
    Tasks Registration Keyword   ${task_name}  ${task_description}  01.01.2020  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created


Start Date After End Date
    Tasks Registration Keyword   ${task_name}  ${task_description}  31.12.2020  30.12.2020  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created

Empty End Date
    Tasks Registration Keyword   ${task_name}  ${task_description}  ${start_date}  ${empty}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created


Start In February
    [Teardown]   Go Back
    sleep   1
    Tasks Registration Keyword   ${task_name}  ${task_description}  01.02.2021  10.02.2021  ${label}
    sleep   2
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created
    Go To  http://localhost:3000/tasks
    ${date}=       Get WebElements      class:card
    Element Should Contain     ${date}[-1]    2021-02-01 - 2021-02-17


Start In May
    [Teardown]   Go Back
    sleep   1
    Tasks Registration Keyword   ${task_name}  ${task_description}  01.05.2021  10.05.2021  ${label}
    sleep   2
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created
    Go To  http://localhost:3000/tasks
    ${date}=       Get WebElements      class:card
    Element Should Contain     ${date}[-1]    2021-05-01 - 2021-05-25


Start In November
    [Teardown]   Go Back
    sleep   1
    Tasks Registration Keyword   ${task_name}  ${task_description}  01.11.2021  10.11.2021  ${label}
    sleep   2
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created
    Go To  http://localhost:3000/tasks
    ${date}=       Get WebElements      class:card
    Element Should Contain     ${date}[-1]    2021-11-01 - 2021-12-31


Start In December
    [Teardown]   Go Back
    sleep   1
    Tasks Registration Keyword   ${task_name}  ${task_description}  01.12.2021  10.12.2021  ${label}
    sleep   2
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     Task has been created
    Go To  http://localhost:3000/tasks
    ${date}=       Get WebElements      class:card
    Element Should Contain     ${date}[-1]    2021-12-01 - 2021-12-31


