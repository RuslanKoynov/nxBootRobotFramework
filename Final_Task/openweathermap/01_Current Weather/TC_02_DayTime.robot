***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with daytime more than 12 hours


***Test Cases***
Test day time
    [Documentation]   Выбрать города, продолжительность дня больше 12 часов. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    current weather  day length
    ${result}   Check Daytime    ${get weather data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Day time - @{element}[1].\n
    \       Log     City - @{element}[0]. Day time - @{element}[1].