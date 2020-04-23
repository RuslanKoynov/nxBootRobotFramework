*** Settings ***
Documentation     Получение значений погоды из списка городов. Вывод городов в которых сейчас идет снег 
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
test_004
     ${Len} =   get length   ${list of cities}
        :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Test snow    ${x}