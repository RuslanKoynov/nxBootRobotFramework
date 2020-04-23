***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with given humidity and pressure


***Test Cases***
Test Humidity And Pressure
    [Documentation]   Выбрать города, где влажность воздуха выше 75%, а атмосферное давление больше 770 мм.рт.ст. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    current weather  humidity  pressure
    ${result}   Check Humidity And Pressure    ${get weather data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Humidity - @{element}[1]. pressure - @{element}[2].\n
    \       Log     City - @{element}[0]. Humidity - @{element}[1]. pressure - @{element}[2].