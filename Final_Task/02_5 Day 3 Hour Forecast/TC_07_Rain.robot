***Settings***
Documentation   Test current weather API
Resource  .${/}resource.robot

***Variables***
${error empty}      No cities with description "heavy intensity rain"

***Test Cases***
Test rain description
    [Documentation]   Выбрать города, в которых хотя бы в один из пяти дней погода будет отмечена как "Rain", а в описании будет значение "heavy intensity rain". Если таких нет, то вывести соответствующее сообщение.
    [Tags]    5 day forecast  rain
    ${result}   Check Rain Description    ${get forecast data result}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${error timeout}    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error timeout}
    ${status}=    Run Keyword And Return Status    Should Not Be Equal As Strings    None    ${result}
    Run Keyword If     not ${status}    Append If Failed    ${error empty}
    : FOR   ${element}   IN   @{result}
    \       Append To File  results.log   City - @{element}[0]. Heavy intensity rain - @{element}[1].\n
    \       Log     City - @{element}[0]. Heavy intensity rain - @{element}[1].


