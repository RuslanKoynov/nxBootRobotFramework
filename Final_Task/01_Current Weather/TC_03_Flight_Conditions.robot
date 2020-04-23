***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with good flying conditions


***Test Cases***
Test Flight Conditions
    [Documentation]   Выбрать города, где видимость больше 300 метров, а скорость ветра меньше 20 м/с. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    current weather  flight conditions
    ${result}   Check Flight Conditions    ${get weather data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - ${element}. Good conditions.\n
    \       Log     City - ${element}. Good conditions.