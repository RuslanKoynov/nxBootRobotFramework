*** Settings ***
Documentation    Тесты для раздела Current weather data
Resource         .${/}resource.robot
Suite Setup      create session      Get_current_weather     ${Base_URL}
Test Timeout     2 minutes


*** Test Cases ***
01_get_temperature
    [Documentation]     Тест выводит города, в которых температура воздуха больше 25 градусов Цельсия
    [Tags]              temperature
    @{City_id_list}     get id   # получаем список id городов
    # Если таймаут превышен, через 5 секунд повторяем вызов. После трех неудачных попыток тест не пройден
    :FOR        ${item}     IN         @{City_id_list}
    \       ${result}=   Wait Until Keyword Succeeds	3x  5 s    get temperature     ${item}    ${result}
    run keyword if      ${result}==0    FAIL      no cities

02_get_day_length
    [Documentation]     Тест выводит города, в которых продолжительность светового дня больше 12 часов
    [Tags]              day length
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторяем вызов. После трех неудачных попыток тест не пройден
    :FOR        ${item}     IN        @{City_id_list}
    \       ${result}=    Wait Until Keyword Succeeds	3x  5 s  get day length     ${item}    ${result}
    run keyword if      ${result}==0    FAIL      no cities

03_get_conditions
    [Documentation]     Тест выводит города, в которых видимость больше 300 метров, а скорость ветра меньше 20 м/с.
    [Tags]              wind    visibility
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторяем вызов. После трех неудачных попыток тест не пройден
    :FOR        ${item}     IN       @{City_id_list}
    \  ${result}=     Wait Until Keyword Succeeds  3x  5 s  Get visibility and wind   ${item}  ${result}
    run keyword if      ${result}==0    FAIL      no cities #если городов удовлетворяющих условиям нет, то тест не пройден

04_get_snow_cities
    [Documentation]     Тест выводит города, в которых в данный момент идет снег.
    [Tags]              snow
    @{City_id_list}     get id
    :FOR        ${item}     IN        @{City_id_list}
    \       ${result}=   Wait Until Keyword Succeeds  3x  5 s   Get snow     ${item}   ${result}
    run keyword if      ${result}==0    FAIL      no cities

05_get_pr_h
    [Documentation]     Тест выводит города, в которых влажность воздуха больше 75%, а атмосферное давление > 770 мм рт.ст.
    [Tags]              presure    humidity
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторяем вызов. После трех неудачных попыток тест не пройден
    :FOR        ${item}     IN       @{City_id_list}
    \       ${result}=  Wait Until Keyword Succeeds	3x  5 s   Get pressure and humidity   ${item}  ${result}
    run keyword if      ${result}==0    FAIL      no cities


*** Keywords ***

Get pressure and humidity
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}   # ответ на запрос
    ${json} =           set variable    ${json.json()}
    &{main} =           Get From Dictionary    ${json}    main
    # если найдется хотя бы один город, удовлетворяющий условиям, то 1, иначе 0
    ${success}=         set variable if    ${main}[pressure] > 770 and ${main}[humidity] > 75       1     ${success}
    run keyword if      ${main}[pressure] > 770 and ${main}[humidity] > 75  log    City - &{json}[name]. Humidity - ${main}[humidity]. Pressure - ${main}[pressure]
    [Return]            ${success}

Get snow
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    ${json} =           set variable    ${json.json()}
    ${weather}=         Get From Dictionary    ${json}    weather
    ${weather} =        Get From Dictionary     @{weather}[0]    main
    # если найдется хотя бы один город, удовлетворяющий условиям, то 1, иначе 0
    ${success}=         set variable if     '${weather}' == 'Snow'      1     ${success}
    run keyword if      '${weather}' == 'Snow'     log   City - &{json}[name].Snow
    [Return]            ${success}

Get visibility and wind
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    ${json} =           set variable    ${json.json()}
    &{wind} =           Get From Dictionary    ${json}    wind
    ${visibility}=      set variable  visibility
    ${visibility}=      Run keyword if   $visibility in $json     Get From Dictionary    ${json}    visibility
    # если найдется хотя бы один город, удовлетворяющий условиям, то 1, иначе 0
    ${success}=         set variable if    ${visibility}!=None and ${wind}[speed] < 20 and ${visibility} > 300        1     ${success}
    run keyword if      ${visibility}!=None and ${wind}[speed] < 20 and ${visibility} > 300     log   City - &{json}[name]. Good conditionals
    [Return]            ${success}

Get requests
    [Arguments]         ${City id}
    [Timeout]           5 seconds
    ${responce}=        get request     Get_current_weather     /weather?id=${City id}&units=metric&appid=${Key}
    [Return]            ${responce}

Get temperature
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    ${json} =           set variable    ${json.json()}
    &{main} =           Get From Dictionary    ${json}    main
    # если найдется хотя бы один город, удовлетворяющий условиям, то 1, иначе 0
    ${success}=         set variable if     &{main}[temp] > 25            1     ${success}
    run keyword if      &{main}[temp] > 25     log   City - &{json}[name].Temperature - &{main}[temp]
    [Return]            ${success}

Get day length
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    ${json} =           set variable    ${json.json()}
    &{sys} =            Get From Dictionary    ${json}    sys
    ${day_length} =     Evaluate    (${sys}[sunset] - ${sys}[sunrise])/3600
    # если найдется хотя бы один город, удовлетворяющий условиям, то 1, иначе 0
    ${success}=         set variable if    ${day_length}>12           1     ${success}
    run keyword if      ${day_length}>12     log   City - &{json}[name].Day_length - ${day_length} h
    [Return]            ${success}
