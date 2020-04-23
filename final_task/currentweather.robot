*** Settings ***
Documentation	Robot final test current weather
Resource         resource.robot

*** Variables ***
${LOGIN URL}	http://google.com
${API2}			http://api.openweathermap.org
${API KEY}		&appid=a0529df520ec195c2f2c28b653271404
${API11}		api.openweathermap.org/data/2.5/weather?q=London&appid=a0529df520ec195c2f2c28b653271404
${BROWSER}		chrome
${id}			536203

*** Test Cases ***
	
Test One Temperature
	[Documentation] 	Города, в которых температура воздуха больше 25 градусов Цельсия.
	
	#create session		First		${API2}
	#${json_string}  Get File    D:/Robot/final_task/city.list.json
	#${json_object} 	 	Set Variable	    ${json_string}
	#:FOR  ${item}    IN    ${json_object}
	#\	${response}=		get request		First	data/2.5/weather?id=${item['id']}${API KEY}
	#\Log 		${response.text}
#	${result_name}	   ${result_temperature}	Get Temp From Citys
	${result_name}	   Get Temp From Citys		#вызов соответствующей функции из библиотеки
	#Run Keyword If		${result_name} != '' 	Log		${result_name}
	Run Keyword If			len(${result_name}) > 0 	Log dictionary		${result_name}	#проверка на пустоту словаря и вывод информации
	Run Keyword Unless		len(${result_name}) > 0 	Log 		Отсутствие городов с температурой больше 25

Test Two Sundaytime
	[Documentation]		Города, в которых солнечное время длится больше 12 часов
	${result}			Get Sundaytime
	Run Keyword If			len(${result}) > 0 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 	Log 				Отсутствие городов c солнечным временем больше 12
	
Test Three Flycheck
	[Documentation]		Города, в которых удовлетворительное состояние аэропортов
	${result}			Get Good Fly Airports
	Run Keyword If			len(${result}) > 0 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 	Log 				Отсутствие городов, в которых удовлетворительное состояние аэропортов
	
Test Four Flycheck
	[Documentation]		Города, в которых идёт снег
	${result}			Get City With Snow
	Run Keyword If			len(${result}) > 0 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 	Log 				Отсутствие городов, в которых идёт снег
	
Test Five Davlenie+Vlagnost
	[Documentation]		Города, в которых влажность > 75% и давление > 770 мм рт. ст.
	${result}			Get Vlagnost And Davlenie
	Run Keyword If			len(${result}) > 0 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 	Log 				Отсутствие городов, в которых влажность > 75% и давление > 770 мм рт. ст.