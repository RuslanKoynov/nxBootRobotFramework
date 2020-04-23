*** Settings ***
Documentation     Получение значений погоды за 5 дней из списка городов. Вывод городов с различаем вечерних и утренних температур выше 10 градусов 
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
Test_008
    ${Len} =   get length   ${list of cities}
        :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Temperature    ${x}