***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with cloudiness above 90 percents

***Test Cases***
Test Cloudiness
    [Documentation]   Выбрать города, процент облаков больше 90 процентов. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    5 day forecast  clouds
    ${result}   Check Clouds Percents    ${get forecast data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Clouds - @{element}[1]. date - @{element}[2].\n
    \       Log     City - @{element}[0]. Clouds - @{element}[1]. date - @{element}[2].


