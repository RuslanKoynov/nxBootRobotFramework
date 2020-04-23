*** Settings ***
Documentation     Получение значений погоды из списка городов. Вывод городов с температурой выше 25 градусов 
Resource     .${/}resource.robot
Test Timeout    2 minutes
*** Test case ***
Test_001
   ${Len} =   get length   ${list of cities}
          # Перебор всех данных от городов 
          :FOR   ${i}   IN range   0    ${Len}
    \     ${x}  Get From List   ${list of cities}    ${i}
    \    Test temperature    ${x}