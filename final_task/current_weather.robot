*** Settings ***
Documentation     Работа с разделом Current Weather.
...               Все библиотеки включены в файл ресурсов.
...               Индексы городов получены из файла city.list.json и для удобства записаны в файл id.txt.
...               Результаты работы тестов записываются  в отдельные файлы с расширением .log

Resource          resource.robot


*** Variables ***
${base_url}    https://api.openweathermap.org
${api_key}     9337d0dfa201f5632d4464e58d0b7c4a
${path}        ${CURDIR}${/}libraries${/}id.txt


*** Test Cases ***

Get Temperature Info
    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых температура воздуха больше 25 градусов Цельсия
    [Tags]             temperature
    [Timeout]          2 minutes


    Create Session    session    ${base_url}
    Create File       ${CURDIR}${/}temperature.log        # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}                    # считываем данные из файла, содержащего id городов
    @{lines}    Split To Lines    ${txt_data}             # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Задаем параметру units значение metric, чтобы получить температуру в градусах Цельсия
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}      # значение полученного запроса переводим в json формат
    \    ${temperature}=    get value from json   ${json_data}    $.list[0].main.temp  # получаем значение температуры, используя json path
    \    ${city_name}=      get value from json   ${json_data}    $.list[0].name       # получаем название города, используя json path
         # Если температура больше 25 градусов цельсия, записываем название города и температуру в нем в файл  temperature.log
    \    Run Keyword If   ${temperature}[0] > 25   Append To File    ${CURDIR}${/}temperature.log    City - ${city_name}[0]. Temperature - ${temperature}[0].\n
    ${data}=     get file   ${CURDIR}${/}temperature.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}temperature.log    It is less than 25 degrees in these cities.

Get Day Length Info
    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых продолжительность дня больше 12 часов
    [Tags]             day lenght
    [Timeout]          2 minutes

    Create Session    session   ${base_url}
    Create File       ${CURDIR}${/}day_lenght.log   # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}              # считываем данные из файла, содержащего id городов
    @{lines}    Split To Lines    ${txt_data}       # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=      to json   ${resp.content}  # значение полученного запроса переводим в json формат
    \    ${city_name}=      get value from json   ${json_data}    $.list[0].name          # получаем название города, используя json path
    \    ${sunrise}=        get value from json   ${json_data}    $.list[0].sys.sunrise   # получаем время восхода, используя json path
    \    ${sunset}=         get value from json   ${json_data}    $.list[0].sys.sunset    # получаем время заката, используя json path
         # Вычисляем количество часов между временем восхода и заката. Так как разница вычисляется в секундах, делим ее на количество секунд в часе
    \    ${difference}=     evaluate  (${sunset}[0]-${sunrise}[0])/3600
         # Если разница больше 10 часов, записываем название города и продолжительностб дня в файл day_lenght.log
    \    run keyword if     ${difference} > 10   Append To File    ${CURDIR}${/}day_lenght.log    City - ${city_name}[0]. Day length - ${difference}.\n
    ${data}=     get file   ${CURDIR}${/}day_lenght.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}day_lenght.log    The lenght of the day is less than 10 hours in these cities.


Get Wheather Condition Info
    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых скорость ветра меньше 20 м/с и видимость больше 300 метров
    [Tags]             weather conditions   visibility  wind speed
    [Timeout]          2 minutes

    Create Session    session    ${base_url}
    Create File       ${CURDIR}${/}wheather_condition.log       # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}                          # считываем данные из файла, содержащего id городов
    @{lines}    Split To Lines    ${txt_data}                   # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}   # значение полученного запроса переводим в json формат
    \    ${visibility}=    get value from json   ${json_data}    $.list[0].visibility    # получаем значение видимости, используя json path
    \    ${wind_speed}=    get value from json   ${json_data}    $.list[0].wind.speed    # получаем скорость ветра, используя json path
    \    ${city_name}=     get value from json   ${json_data}    $.list[0].name          # получаем название города, используя json path
         # Если скорость ветра меньше 20 м/с и видимость больше 300 метров, добавляем в файл wheather_condition сообщение о хороших погодных условиях в городе
    \    run keyword if     ${wind_speed}[0] < 20 and ${visibility} > [300] and ${visibility} != [${empty}]    Append To File    ${CURDIR}${/}wheather_condition.log    City - ${city_name}[0]. Good conditions.\n
    ${data}=     get file    ${CURDIR}${/}wheather_condition.log
    ${number_of_relevant_cities} =  get line count  ${data}  # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет

    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}wheather_condition.log    There is a bad weather in these cities.





Get Snow Info
    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых идет снег
    [Tags]             snow
    [Timeout]          2 minutes

    Create Session    session    ${base_url}
    Create File       ${CURDIR}${/}snow.log        # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}             # считываем данные из файла, содержащего id городов
    @{lines}    Split To Lines    ${txt_data}      # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}   # значение полученного запроса переводим в json формат
    \    ${condition}=    get value from json   ${json_data}    $.list[0].weather[0].main   # получаем погодные условия, используя json path
    \    ${city_name}=      get value from json   ${json_data}    $.list[0].name   # получаем название города, используя json path
         # Если в городе идет снег, выводим сообщение об этом в файл  snow.log
    \    run keyword if   '${condition}[0]' == 'Snow'     Append To File    ${CURDIR}${/}snow.log    City - ${city_name}[0]. Snow.\n
    ${data}=     get file   ${CURDIR}${/}snow.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File  ${CURDIR}${/}snow.log    It doesn't snow in these cities.            # Append To File    ${CURDIR}${/}snow.log    It doesn't snow in these cities.


Get Humidity And Pressure Info
    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых влажность воздуха больше 75%, а атмосферное давление больше 770 мм рт.ст.
    [Tags]             pressure   humidity
    [Timeout]          2 minutes

    Create Session    session    ${base_url}
    Create File       ${CURDIR}${/}humidity_and_pressure.log   # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}                         # считываем данные из файла, содержащего id городов
    @{lines}    Split To Lines    ${txt_data}                  # для каждого повторяем
     # Отправляем get запрос с полученным  id
     # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    :FOR    ${line}    IN    @{lines}
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}   # значение полученного запроса переводим в json формат
    \    ${pressure}=    get value from json   ${json_data}    $.list[0].main.pressure     # получаем давление, используя json pathv
    \    ${humidity}=      get value from json   ${json_data}    $.list[0].main.humidity   # получаем влажнось, используя json path
    \    ${city_name}=      get value from json   ${json_data}    $.list[0].name           # получаем название города, используя json path
         # Если влажность воздуха больше 75% и атмосферное давление больше 770 мм рт.ст., то выводим в файл humidity_and_pressure.log сообщение об этом.
    \    run keyword if     ${humidity}[0] > 75 and ${pressure}[0] > 770    Append To File    ${CURDIR}${/}humidity_and_pressure.log    City - ${city_name}[0]. Humidity - ${humidity}[0]. Pressure - ${pressure}[0].\n
    ${data}=     get file   ${CURDIR}${/}humidity_and_pressure.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}humidity_and_pressure.log    There are no suitable cities.


*** Keywords ***

Get Request Keyword
     [Arguments]   ${arg}         # в качестве аргумента передается id города из списка городов
     [Return]      ${response}    # возвращаем ответ
     [Timeout]     5              # таймаут выполнения запроса 5 секунд
     # Dыполнение запроса для получения информации о погоде в городе по id
     # Задаем параметру units значение metric, чтобы получить температуру в градусах Цельсия
     ${response}=     get request    session   data/2.5/group?id=${arg}&units=metric&appid=${api_key}
     Request Should Be Successful    ${response}






