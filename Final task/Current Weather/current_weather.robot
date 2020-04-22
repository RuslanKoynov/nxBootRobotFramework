*** Settings ***
Documentation    Current Weather Task
Resource     ./resource.robot


*** Test Cases ***
Air Temperature
    [Documentation]    Города, где температура выше 25 градусов по Цельсию
    [Tags]  temperature
    ${result}    ${flag} =  get temp    
    Run Keyword If    '${flag}' == 'True'    Log    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Везде не так жарко!

Daylight Length
    [Documentation]    Города, где продолжительность светового дня больше 12 часов 
    [Tags]  daylight
    ${result}    ${flag} =  get daylight
    Run Keyword If    '${flag}' == 'True'    Log    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Светло меньше 12 часов в сутки!

Airport Conditions
    [Documentation]    Города с благоприятными условиями для аэропортов
    [Tags]  airport
    ${result}    ${flag} =  get airport
    Run Keyword If    '${flag}' == 'True'    Log    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Улететь не получиться :(

Snow Weather
    [Documentation]    Города, где сейчас идёт снег
    [Tags]  snow
    ${result}    ${flag} =  get snow weather
    Run Keyword If    '${flag}' == 'True'    Log    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Снега нет!

Humidity And Pressure
    [Documentation]    Города влажностью воздуха больше 75% и атм. давлением больше 770 мм рт.ст.
    [Tags]  humidity, pressure
    ${result}    ${flag} =  get humidity and pressure
    Run Keyword If    '${flag}' == 'True'    Log    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Везде сухо и не давит :)