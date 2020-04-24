*** Settings ***
Documentation    Тесты для раздела 5 day / 3 hour forecast
Resource         .${/}resource.robot
Suite Setup      create session      Get_current_weather     ${Base_URL}
Test Timeout     2 minutes

*** Test Cases ***
01_get_clouds
    [Documentation]     Тест выводит города, в которых хотя бы в один из пяти дней облачность будет больше 90%
    [Tags]              clouds
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторить вызов. После трех неудачных попыток считать тест не пройденным
    :FOR        ${item}     IN         @{City_id_list}
    \       ${result}=   Wait Until Keyword Succeeds  3x  5 s   get clouds     ${item}    ${result}
    run keyword if      ${result}==0    FAIL      no cities

02_get_rain
    [Documentation]     Тест выводит города,в которых хотя бы в один из пяти дней погода будет отмечена как "Rain",
    ...                 а в описании будет значение "heavy intensity rain"
    [Tags]              rain
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторить вызов. После трех неудачных попыток считать тест не пройденным
    :FOR        ${item}     IN         @{City_id_list}
    \       ${result}=  Wait Until Keyword Succeeds  3x  5 s    get rain     ${item}    ${result}
    run keyword if      ${result}==0    FAIL      no cities

03_get_difference_of_temperature
    [Documentation]     Тест выводит города, в которых хотя бы в один из пяти дней разница температуры утром(09:00)
     ...                и в дневное время(15:00) будет больше 10 градусов
     [Tags]             temperature
    @{City_id_list}     get id
    # Если таймаут превышен, через 5 секунд повторить вызов. После трех неудачных попыток считать тест не пройденным
    :FOR        ${item}     IN         @{City_id_list}
    \       ${result}=  Wait Until Keyword Succeeds  3x  5 s  get difference     ${item}    ${result}
    run keyword if      ${result}==0    FAIL      no cities


*** Keywords ***
Get requests
    [Arguments]         ${City id}
    [Timeout]           5 seconds
    ${responce}=        get request     Get_current_weather     /forecast?id=${City id}&units=metric&appid=${Key}
    ${json} =           set variable    ${responce.json()}
    [Return]            ${json}

Get clouds
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    @{list} =           Get From Dictionary    ${json}    list
    :FOR        ${item}     IN         @{list}
    \        Run keyword if     ${item}[clouds][all] > 90   log  City - ${json}[city][name]. Clouds - ${item}[clouds][all], date -${item}[dt_txt]
    \        ${success}=         set variable if    ${item}[clouds][all] > 90       1     ${success}
    [Return]            ${success}

Get Rain
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    @{list} =           Get From Dictionary    ${json}    list
    :FOR        ${item}     IN         @{list}
    \        Run keyword if     '${item}[weather][0][main]'=='Rain' and '${item}[weather][0][description]'=='heavy intensity rain'   log  City - ${json}[city][name]. Heavy intensity rain -${item}[dt_txt]
    \        ${success}=         set variable if    '${item}[weather][0][main]'=='Rain' and '${item}[weather][0][description]'=='heavy intensity rain'      1     ${success}
    [Return]            ${success}


Get difference
    [Arguments]         ${City id}      ${success}
    ${json} =           Get requests      ${City id}
    @{list} =           Get From Dictionary    ${json}    list
    # ищем индекс элемента у которого в поле даты стоит 9 утра
    :FOR        ${item}     IN RANGE     8
    \           ${datetime} =    Convert Date   ${list}[${item}][dt_txt]        datetime
    \           ${morning_start_item}=         set variable     ${item}
    \           Exit For Loop IF    ${datetime.hour}== 9
    # прогноз через каждые 3 часа, т.е в сутках их 8
    # для каждого дня считаем разницу температур в 9 и 15 часов
    :FOR     ${item}     IN RANGE      ${morning_start_item}   38     8
    \        ${difference}=   Evaluate     abs(${list}[${item}][main][temp] - ${list}[${item + 2}][main][temp])
    \        ${date} =	Convert Date	${list}[${item}][dt_txt] 	result_format=%d.%m.%Y
    \        Run keyword if   ${difference}>10    log    City- ${json}[city][name] .Difference- ${difference} . Date- ${date}
    \        ${success}=         set variable if    ${difference}>10     1     ${success}
    [Return]            ${success}