***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with snow


***Test Cases***
Test Snow
    [Documentation]   Выбрать города, где в данный момент времени идет снег. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    current weather  snow
    ${result}   Check Current Weather    ${get weather data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - ${element}. Snow.\n
    \       Log     City - ${element}. Snow.