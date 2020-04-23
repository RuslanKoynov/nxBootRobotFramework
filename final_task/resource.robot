*** Settings ***
Documentation	First robot test
Library			OperatingSystem
Library			String
Library			Collections
Library			Process
Library  		RequestsLibrary
#Library    		HttpLibrary.HTTP
Library     ${CURDIR}/currentweather.py
Library     ${CURDIR}/5_day_3_hours_forecast.py

*** Variables ***
${USER}			Gleb

*** Keywords ***
My keywords №1
	[Documentation]		*Проверка* _на неравенство_
	[Arguments]		${a}	${b}
	Log 	Arguments is ${a} и ${b}
	Should not be equal 	${a}	${b}

My keywords №2
	[Documentation]		*Проверка* _на неравенство2_
	[Arguments]		${arg1}		${arg2}=10
	Log 		Arguments is ${arg1} и ${arg2}
	${tmp}		Evaluate 	${arg1}+${arg2}
	[Return]	${tmp}

My keywords №3
	[Documentation]		*Возвращает* _время_
	${tmp1}=		Get Time     hour    NOW
	${tmp2}=		Get Time     min    NOW  
	Create File		${CURDIR}/practice_4/logs/log.txt 		${tmp1}:${tmp2}