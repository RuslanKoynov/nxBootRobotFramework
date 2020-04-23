*** Settings ***
Documentation     Получение значений погоды из списка городов. Вывод городов С видимостью больше 300 метров и скоростью ветра мегьше 20 метров
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
test_003
        ${Len} =   get length   ${list of cities}
        :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Good Conditions    ${x}