*** Settings ***
Documentation	    Тест-кейсы для five days/three hours weather
Resource            resource.robot
Force Tags          final task


*** Test Cases ***
Cloudy
  [Documentation]	Города, облачность выше 90%
  ${DICT} =             cloudy
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет

Rainy
  [Documentation]	Города, c ливневым дождем
  ${DICT} =             rainy
  Run Keyword If        ${DICT}   log dictionary   ${DICT}
  Run Keyword Unless    ${DICT}   Fail             Таких городов нет
