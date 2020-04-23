*** Settings ***
Documentation	    Тест-кейсы для current weather
Resource            resource.robot
Force Tags          final task


*** Test Cases ***
Temperature
  [Documentation]	Города, с температурой выше 25 градусов
  ${DICT} =             temp25
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет
  
Vis And Speed
  [Documentation]	Города, видимость > 300м, скоростью ветра < 20м/c
  ${DICT} =             vis_speed
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет

Snowy Cities
  [Documentation]	Снежные города
  ${DICT} =             snow
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет

Hum And Press  
  [Documentation]	Влажность > 75%, атм. давление > 700мм.рт.ст
  ${DICT} =             hum_press
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет