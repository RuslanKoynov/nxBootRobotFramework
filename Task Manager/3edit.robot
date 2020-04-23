*** Settings ***
Documentation  Редактирование задачи
Resource       resource.robot

*** Test Cases ***
Editing Task
   [Documentation]	Изменение поля Status
   [Setup]		Open Brows
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=1 secs
   Click Element	xpath://*[contains(text(), "Edit")]
   Wait For Process     timeout=1 secs
   Click Element        name:task_status
   Wait For Process     timeout=1 secs
   Click Element        xpath://*[contains(text(), "Closed")]
   Wait For Process     timeout=1 secs
   Click Element	xpath://*[contains(text(), "Update")]
   Wait For Process      timeout=3 secs
   Page Should Contain   Task has been updated
   [Teardown]           Close Browser
   