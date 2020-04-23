*** Settings ***
Documentation     Получение значений погоды из списка городов. Вывод городов с влажностью выше 75 % и атм. давлением выше 770 мм.рт.с 
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
test_005
     ${Len} =   get length   ${list of cities}
        :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Humidity    ${x}