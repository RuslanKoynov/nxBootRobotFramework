*** Settings ***
Documentation     Получение значений погоды из списка городов. Вывод городов с длительностью дня больше 12 часов  
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
Test_002
	${Len} =   get length   ${list of cities}
       :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Test daylength    ${x}