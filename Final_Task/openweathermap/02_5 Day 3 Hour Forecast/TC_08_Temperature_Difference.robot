***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with temperature difference more than 10 degrees

***Test Cases***
Test temperature difference
    [Documentation]   Выбрать города, в которых хотя бы в один из пяти дней разница температуры утром (6 утра) и в дневное время (12 часов дня)
    ...               будет больше 10 градусов. Если таких нет, то вывести соответствующее сообщение.
    [Tags]    5 day forecast  temperature
    ${result}   Check Temperature Difference    ${get forecast data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Temperature difference - @{element}[1] Date - @{element}[2].\n
    \       Log     City - @{element}[0]. Temperature difference - @{element}[1] Date - @{element}[2].


