***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with temperature above 25 degrees

***Test Cases***
Test temperature
    [Documentation]   Выбрать города, где температура больше 25 градусов Цельсия. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    current weather  temperature
    ${result}   Check If Above 25 Degrees    ${get weather data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Temperature - @{element}[1].\n
    \       Log     City - @{element}[0]. Temperature - @{element}[1].


