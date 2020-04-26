*** Settings ***
Documentation     Примеры проверки регистрации пользователя с различными значениями имени
Resource          resource.robot
Suite Setup       Open Browser    http://localhost:3000/users/create    chrome
Suite Teardown    Close Browser

# изменить sleep
# дропать базу перед тестом

*** Test Cases ***
Register User With Valid Name
    User Registration Keyword    Иван Иванов
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Be     ${alert}     User has been created

Register User With Invalid Name
    User Registration Keyword    @#&.
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}    User has been created

Register User With Empty Name
    Click Element    class:btn
    sleep   1
    Alert Should Be Present   Please fill user name

Register User With Space Name
    User Registration Keyword    ${space}
    sleep   1
    Alert Should Be Present   Please fill user name

*** Keywords ***
