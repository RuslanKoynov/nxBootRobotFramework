*** Settings ***
Documentation     Работа с разделом 5 day / 3 hour forecast.
...               Все библиотеки включены в файл ресурсов.
...               Индексы городов получены из файла city.list.json и для удобства записаны в файл id.txt.
...               Результаты работы тестов записываются  в отдельные файлы с расширением .log

Resource          resource.robot

*** Variables ***
${base_url}    https://api.openweathermap.org
${api_key}     9337d0dfa201f5632d4464e58d0b7c4a
${path}        ${CURDIR}${/}libraries${/}id.txt


*** Test Cases ***

Get Clouds Percent Info

    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых хотя бы в один из пяти дней облачность будет больше 90%.
    [Tags]             clouds
    [Timeout]          2 minutes

    Create Session    session    ${base_url}
    Create File       ${CURDIR}${/}clouds.log   # создаем файл для записи результатов
    ${txt_data}    Get File    ${path}
    @{lines}    Split To Lines    ${txt_data}   # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}   # значение полученного ответа на запрос переводим в json формат
    \    ${city_name}=      get value from json   ${json_data}    $.city.name    # получаем название города, используя json path
    \    Clouds Keyword          ${json_data}  ${city_name}

    ${data}=     get file   ${CURDIR}${/}clouds.txt
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}clouds.log
    ...    There are no cities with more than 90 cloud cover%.


Get Weather Conditions And Description Info

    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых хотя бы в один из пяти дней погода будет отмечена как "Rain",
    ...                а в описании будет значение "heavy intensity rain".
    [Tags]             conditions and description
    [Timeout]          2 minutes

    Create File       ${CURDIR}${/}condition_and_description.log   # создаем файл для записи результатов
    Create Session    session         ${base_url}
    ${txt_data}    Get File    ${path}
    @{lines}          Split To Lines    ${txt_data}                # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}    # значение полученного ответа на запрос переводим в json формат
    \    ${city_name}=     get value from json   ${json_data}    $.city.name       # получаем название города, используя json path
    \    Conditions And Description Keyword      ${json_data}    ${city_name}

    ${data}=     get file   ${CURDIR}${/}condition_and_description.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}condition_and_description.log
    ...   There are no cities with such weather conditions.

Get Difference In Temperature Info

    [Documentation]    Тест для получения информации о погоде и вывода городов,
    ...                в которых разница температур в одно и то же время между соседними днями больше 10 градусов.
    ...                Например, в 8 утра сегодня и завтра, завтра и послезавтра и т.д.
    ...                В лог файл выводится город, разница температур, а так же время и дата обоих дней.
    [Tags]             difference   temperature
    [Timeout]          2 minutes

    Create File       ${CURDIR}${/}temperature_difference.log   # создаем файл для записи результатов
    Create Session    session         ${base_url}
    ${txt_data}    Get File    ${path}
    @{lines}          Split To Lines    ${txt_data}                # для каждого повторяем
    :FOR    ${line}    IN    @{lines}
         # Отправляем get запрос с полученным  id
         # Дается 3 попытки на совершение запроса с перерывом в 5 секунд, после трех неудачных попыток тест считается непройденным
    \    ${resp}=  Wait Until Keyword Succeeds	3 times  5 sec  Get Request Keyword    ${line}
    \    ${json_data}=     to json   ${resp.content}    # значение полученного ответа на запрос переводим в json формат
    \    ${city_name}=     get value from json   ${json_data}    $.city.name       # получаем название города, используя json path
    \    Difference In Temperature      ${json_data}    ${city_name}

    ${data}=     get file   ${CURDIR}${/}temperature_difference.log
    ${number_of_relevant_cities} =  get line count  ${data}   # подсчитываем количество строк в файле с результатами
    # если кол-во строк равно нулю (то есть файл пуст), добавляем в него сообщение о том, что городов с заданными параметрами нет
    Run Keyword If  ${number_of_relevant_cities} == 0   Append To File    ${CURDIR}${/}temperature_difference.log
    ...  There are no cities with a temperature difference of more than 10 degrees between neighboring days.



*** Keywords ***
Clouds Keyword
    [Tags]        clouds
    [Arguments]   ${arg1}  ${arg2}
    # для всех 40 полученных за 5 дней (через каждые 3 часа)  прогнозов погоды повторяем
    :FOR     ${i}   IN RANGE   0  40
         \   ${clouds}=         get value from json   ${arg1}    $.list[${i}].clouds.all   # получаем значение облачности, используя json path
         \   ${date}=           get value from json   ${arg1}    $.list[${i}].dt         # получаем время и дату, используя json path
         \   ${d}=              isotime               ${date}[0]
         \   run keyword if     ${clouds}[0] > 90   Append To File    ${CURDIR}${/}clouds.log
         ...  City - ${arg2}[0]. Clouds - ${clouds}[0], date - ${d}\n  # date -  ${d}\n


Conditions And Description Keyword
    [Tags]        conditions and description
    [Arguments]   ${arg1}   ${arg2}
    :FOR     ${i}   IN RANGE   0  40
         \   ${weather_id}=     get value from json   ${arg1}    $.list[${i}].weather[0].id    # получаем индекс погоды, используя json path
         \   ${date}=           get value from json   ${arg1}    $.list[${i}].dt         # получаем время и дату, используя json path
         \   ${d}=              isotime               ${date}[0]
              #Если индекс погоды равент  502 (это индекс, соответствующий данным условиям), записываем город и дату в  condition_and_description.log
         \    run keyword if     ${weather_id}[0] == 502   Append To File    ${CURDIR}${/}condition_and_description.log
         ...    City - ${arg2}[0]. Heavy intensity rain - ${d}.\n


Difference In Temperature
    [Tags]        difference   temperature
    [Arguments]   ${arg1}   ${arg2}
    # Рассмотрим разницу температур между соседними днями во время, соответствующее времени отправления запроса
    # Так как на 24 часа дается 8 прогнозов погоды, повторяем с интервалом в 8
    :FOR     ${i}   IN  0  8  16  24
         \    ${j}=   evaluate  ${i} + ${8}  # переменная для получения прогноза погоды через сутки
         \    ${temperature1}=     get value from json   ${arg1}    $.list[${i}].main.temp    # получаем температуру в заданное время, используя json path
         \    ${temperature2}=     get value from json   ${arg1}    $.list[${j}].main.temp    # получаем температуру через сутки после заданного времени, используя json path
         \    ${date1}=            get value from json   ${arg1}    $.list[${i}].dt           # получаем время и дату текущего запроса, используя json path
         \    ${d1}=               isotime               ${date1}[0]                          # переводим дату в другой формат
         \    ${date2}=            get value from json   ${arg1}    $.list[${j}].dt           # получаем время и дату следующего запроса, используя json path
         \    ${d2}=               isotime               ${date2}[0]                          # переводим дату в другой формат
         \    ${diff}=             evaluate  ${temperature1}[0]-${temperature2}[0]            # находим разницу в температуре между соседними днями, используя json path
              #Если разница более 10 градусов Цельсия, записываем в файл temperature_difference.log город, разницу и даты.
         \    run keyword if     ${diff} > 10   Append To File    ${CURDIR}${/}temperature_difference.log
         ...  City - ${arg2}[0]. Temperature difference - ${diff}. Date 1 - ${d1}[0], date 2 - ${d2}[0].\n



Get Request Keyword
     [Arguments]   ${arg}          # в качестве аргумента передается id города из списка городов
     [Return]      ${response}     # возвращаем ответ
     [Timeout]     5               # таймаут выполнения запроса 5 секунд
     # Dыполнение запроса для получения информации о погоде в городе по id
     # Задаем параметру units значение metric, чтобы получить температуру в градусах Цельсия
     ${response}=     get request    session   /data/2.5/forecast?id=${arg}&units=metric&appid=${api_key}
     Request Should Be Successful    ${response}    # ответ не должен содержать ошибки 4## и 5##
