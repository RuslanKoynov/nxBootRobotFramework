*** Settings ***
Documentation  Создание пользователя
Resource       resource.robot

*** Test Cases ***
User Creating
  [Setup]	        Open Brows
  Click Element	        xpath://*[contains(text(), "Users")]
  Wait For Process      timeout=1 secs     
  Click Element	        xpath://*[contains(text(), "Create")]
  Wait For Process      timeout=1 secs
  Input Text            name:user_name        Hazy
  Wait For Process      timeout=1 secs
  Click Element	        xpath://*[@class='btn btn-primary']
  Wait For Process      timeout=3 secs
  Page Should Contain   User has been created
  [Teardown]            Close Browser


User Creating With Incorrect User Name
  [Setup]	        Open Brows
  Click Element	        xpath://*[contains(text(), "Users")]
  Wait For Process      timeout=1 secs     
  Click Element	        xpath://*[contains(text(), "Create")]
  Wait For Process      timeout=1 secs
  Input Text            name:user_name        TEST250vccsvaajxcxasxcvavvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  Wait For Process      timeout=1 secs
  Click Element	        xpath://*[@class='btn btn-primary']
  Wait For Process      timeout=3 secs
  Page Should Not Contain   User has been created
  [Teardown]            Close Browser  



User Creating Empty User Name
  [Setup]	        Open Brows
  Click Element	        xpath://*[contains(text(), "Users")]
  Wait For Process      timeout=1 secs     
  Click Element	        xpath://*[contains(text(), "Create")]
  Wait For Process      timeout=1 secs
  Click Element	        xpath://*[@class='btn btn-primary']
  Wait For Process      timeout=2 secs
  ${alert} =           Handle Alert
  Page Should Not Contain   User has been created
  [Teardown]                Close Browser
  
	                  
  
  
  