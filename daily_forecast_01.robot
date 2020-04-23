*** Settings ***
Documentation     Получение значений погоды на 5 дней из списка городов. Вывод городов с облачностью выше 90%  
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
Test_006
   ${Len} =   get length   ${list of cities}
       :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Clouds    ${x}