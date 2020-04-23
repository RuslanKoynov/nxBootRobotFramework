*** Settings ***
Documentation    Suite description
Library    JsonValidator
Library     RequestsLibrary
Library     JSONLibrary
Library     OperatingSystem
Library     Collections
Library     BuiltIn
Library     String

*** Variables ***
${Base_URL}     http://api.openweathermap.org
@{list of cities}    2015306  1543743   1544583   14256	18918	23814	24851	32723	32767  	41210    50672	52867	53157	53654	54715    55671   56166    56335    	56399	59611	60019	62691	62788	63571	63689 	63795	64013	64435	64460	64536	65170	65785	69500  922773  	922806    923058    923295    924055    924102	 924572   924705    925498     	925789    926747   927246   927834    	527888   527968   528056  528109    528293   529073  	529505   530849   531129    531820   532096   532288   532459  532615   532657  532675   532715  533543  533690  534015  534341  534560  534595  534701   534838   535121  535243  535334  535886  536156  536162  536200  536206   536518   536625  537107  537281  3836846	 3836873 	3836951   3836992 	3837056 	3837124 	3837213	 3837240 	3837441	 3837675 	3837702 	3837980 	3838233 	3838506 	3838583 	3838793 	3838797 	3838854	 3838859	 3838874	 3838902	 3839307	 3839479 	3839490	 3839982 	3840092	 3840300	 3840860	 3840885 	3841490	 3841500 	3841956	 3842190	 3842670 	3842881	 3843123	 3843619 	 3843803 	 3844421	  3844899	 3845330 	3846864 	3846915  3848687 	3848950	 3851331	 3852374 	3852468	 3853354	 3853491	 3853510	 3854895 	3854985	 3855041 	3855065	 3855074 	3855075	 3855116	 3855244	 3855554 	3855666	 3855974	 3856022 	3856231	 3856235 	3858765	 3859384	 3859512	 3859552	 3859828 	3859904 	3859965 	3860164 	3860217 	3860259 	3860443	 3861056	 3861061 	3861344  3861416  3861445  3861678  3861953  3862144  3862240  3862254  3862320  3862351  3862655  3862738  3862981  3863379  3864331  3864375  3865086  3865385  3865424  3865840  3866163  3866242   542327   542334   542374   542420   542461   542463   542464
 
*** Keywords ***
Test temperature
    [Arguments]    ${id}
    create session     Get_Temp     ${Base_URL}
     ${responce}=    get request      Get_Temp      /data/2.5/weather?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     #Получаем Json файл с помощью Api запроса
     ${temperature_list}=  to json   ${responce.content}
     ${temp}   get value from json   ${temperature_list}    $.main.temp
     # Получаем значение температуры
     ${city}   get value from json   ${temperature_list}    $.name
      # Получаем название города
     Run Keyword If   ${temp[0]} > 25  log     City - ${city[0]}. Temperature - ${temp[0]} C.
     # Если температура больше 25 выводим в лог
Test daylength
    [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/weather?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${day_length}=  to json   ${responce.content}
     # Берем значения захода и восхода солнца
     ${rising}   get value from json   ${day_length}    $.sys.sunrise
     ${sunset}   get value from json   ${day_length}    $.sys.sunset
     # Так как значения указаны в секундах, то нам нужна разница между восходом и закатом поделенная на 3600 что бы получить значение в часах
     ${hours}=   evaluate   (${sunset[0]} - ${rising[0]}) / 3600
     # Сокращаем число до десятых
     ${hours}=   convert to number  ${Hours}   1
     # получаем название города
     ${city}   get value from json   ${day_length}    $.name
     # Если полученное нами значение больше 12 выводим сообщение в лог
     Run Keyword If   ${hours} > 12   log   City - ${city[0]}. Day length - ${hours}.

Good Conditions
    [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/weather?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${conditions}=  to json   ${responce.content}
     # Берем значения видимости
     ${visabiliti}   get value from json   ${conditions}    $.visibility
     # Так как значение видимости не всегда есть, то проверяем его наличие
     ${x} =   set variable  0
     ${x} =  set variable If   '${visabiliti}' != '[]'     ${visabiliti[0]}
     # Берем значения скорости ветра и названия города
     ${speed}   get value from json   ${conditions}    $.wind.speed
     ${city}   get value from json   ${conditions}    $.name
     # Если значение видимости есть, больше 300 и значение скорости ветра меньше 20, то выводим сообщение в лог
     Run Keyword If   '${x}' != 'None' and ${x} > 300 and ${speed[0]} < 20  log     City - ${city}. Good condition

Test snow
     [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/weather?id=${id}&appid=9ec705b1972c4ccb4951aee02146124a
     ${weather}=  to json   ${responce.content}
     # Берем показатель статуса погоды и имя города
     ${snow}   get value from json   ${weather}    $.weather..main
     ${city}   get value from json   ${weather}    $.name
     # Если в статусе погоды написано снег, то выводин сообщение в лог
     Run Keyword If   '${snow[0]}' == 'Snow'   log     City - ${city[0]}. Snow.

Humidity
     [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/weather?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${weather}=  to json   ${responce.content}
     # Берем значения влажности, атмосферного давления и название города
     ${hum}   get value from json   ${weather}    $.main.humidity
     ${pres}   get value from json   ${weather}    $.main.pressure
     ${city}   get value from json   ${weather}    $.name
     # Если значение влажности больше 75, а значение атм.давление 770 - выводи сообщение в лог
     Run Keyword If   ${hum[0]} > 75 and ${pres[0]} > 770  log     City - ${city[0]}. Humidity - ${hum[0]}, pressure - ${pres[0]}.

Clouds
     [Arguments]    ${id}
    create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/forecast?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${clouds}=  to json   ${responce.content}
     # Берем значения облачности, название города и время
     ${day0}   get value from json   ${clouds}    $.list..clouds.all
     ${city}   get value from json   ${clouds}    $.city.name
     ${time}   get value from json   ${clouds}    $.list..dt_txt
     # Проверяем все 5 дней, и если облачность больше 90% выводим в лог название города
     Run Keyword If   ${day0[0]} > 90 or ${day0[8]} > 90 or ${day0[16]} > 90 or ${day0[24]} > 90 or ${day0[32]} > 90  log    City - ${city[0]}.     
     # Проверяем 5 дней по отдельности , и если облачность больше 90% выводим в лог облачность и время
     Run Keyword If   ${day0[0]} > 90   log   Clouds - ${day0[0]}. Day - ${time[0]}
     Run Keyword If   ${day0[8]} > 90   log   Clouds - ${day0[8]}. Day - ${time[8]}
     Run Keyword If   ${day0[16]} > 90   log   Clouds - ${day0[16]}. Day - ${time[16]}
     Run Keyword If   ${day0[24]} > 90   log   Clouds - ${day0[24]}. Day - ${time[24]}
     Run Keyword If   ${day0[32]} > 90   log   Clouds - ${day0[32]}. Day - ${time[32]}

Rains
     [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/forecast?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${rains}=  to json   ${responce.content}
     # Берем статус погоды, название города и время
     ${day0}   get value from json   ${rains}    $.list..weather..description
     ${city}   get value from json   ${rains}    $.city.name
     ${time}   get value from json   ${rains}    $.list..dt_txt
     # Проверяем все 5 дней, и если статус "интенсивный дождь" то выводим в лог название города
     Run Keyword If   '${day0[0]}' == 'heavy intensity rain' or '${day0[8]}' == 'heavy intensity rain' or '${day0[16]}' == 'heavy intensity rain' or '${day0[24]}' == 'heavy intensity rain' or '${day0[32]}' == 'heavy intensity rain'  log    City - ${city[0]}.    
     # Проверяем 5 дней по отдельности , и если статус "интенсивный дождь" выводим в лог  время
     Run Keyword If   '${day0[0]}' == 'heavy intensity rain'   log    Heavy intensity rain - ${time[0]}
     Run Keyword If   '${day0[8]}' == 'heavy intensity rain'   log    Heavy intensity rain - ${time[8]}
     Run Keyword If   '${day0[16]}' == 'heavy intensity rain'   log    Heavy intensity rain - ${time[16]}
     Run Keyword If   '${day0[24]}' == 'heavy intensity rain'   log   Heavy intensity rain - ${time[24]}
     Run Keyword If   '${day0[32]}' == 'heavy intensity rain'   log    Heavy intensity rain - ${time[32]}

Temperature
     [Arguments]    ${id}
     create session     Get_Json     ${Base_URL}
     # Получаем файл Json
     ${responce}=    get request      Get_Json      /data/2.5/forecast?id=${id}&units=metric&appid=9ec705b1972c4ccb4951aee02146124a
     ${temp}=  to json   ${responce.content}
     # Получаем температурные значения за 5 дней
     ${day0}   get value from json   ${temp}    $.list..main.temp
     # Отдельно на каждый день расчитываем разницу температуры с разницей в 12 часов
     ${day1}   evaluate  abs(${day0[0]} - ${day0[4]})
     ${day1}=   convert to number  ${day1}   1
     ${day2}   evaluate  abs(${day0[8]} - ${day0[12]})
     ${day2}=   convert to number  ${day1}   1
     ${day3}   evaluate  abs(${day0[16]} - ${day0[20]})
     ${day3}=   convert to number  ${day1}   1
     ${day4}   evaluate  abs(${day0[24]} - ${day0[28]})
     ${day4}=   convert to number  ${day1}   1
     ${day5}   evaluate  abs(${day0[32]} - ${day0[36]})
     ${day5}=   convert to number  ${day1}   1
     # Получаем название города и время
     ${city}   get value from json   ${temp}    $.city.name
     ${time}   get value from json   ${temp}    $.list..dt_txt
     # Если в один из 5 дней разница температуры более 10 градусов выводим название города
     Run Keyword If   ${day1} > 10 or ${day2} > 10 or ${day3} > 10 or ${day4} > 10 or ${day5} > 10  log    City - ${city[0]}.    
     # Выводим разницу температуры и время в лог для тех дней когда это происходило
     Run Keyword If   ${day1} > 10  log   Temperature difference - ${day1}. Day - ${time[0]}
     Run Keyword If   ${day2} > 10  log   Temperature difference - ${day2}. Day - ${time[8]}
     Run Keyword If   ${day3} > 10  log   Temperature difference - ${day3}. Day - ${time[16]}
     Run Keyword If   ${day4} > 10  log   Temperature difference - ${day4}. Day - ${time[24]}
     Run Keyword If   ${day5} > 10  log   Temperature difference - ${day5}. Day - ${time[32]}
