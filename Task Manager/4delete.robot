*** Settings ***
Documentation  Удаление задачи
Resource       resource.robot

*** Test Cases ***
Deleting Task
   [Setup]		Open Brows
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=1 secs
   Click Element	xpath://*[contains(text(), "Delete")]
   Wait For Process      timeout=3 secs
   Page Should Contain   Task has been deleted
   [Teardown]           Close Browser
   
   
   