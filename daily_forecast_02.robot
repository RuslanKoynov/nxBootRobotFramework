*** Settings ***
Documentation     Получение значений погоды за 5 дней из списка городов. Вывод городов с пометкой "heavy intensity rain"
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
Test_007
    ${Len} =   get length   ${list of cities}
        :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Rains    ${x}
