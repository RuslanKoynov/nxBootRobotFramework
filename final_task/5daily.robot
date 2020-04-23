*** Settings ***
Documentation	Robot final test 5 daily check
Resource         resource.robot


*** Test Cases ***
	
Test One Clouds
	[Documentation] 	Города, в которых хотя бы в один из дней будет облачность > 90%

	${result}			    Get Citys With Cloud In 5days
	Run Keyword If			len(${result}) > 0	 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 		Log 		Отсутствие городов, в которых хотя бы в один из дней будет облачность > 90%

Test Two Rains
	[Documentation] 	Города, в которых хотя бы в один из дней будет дождь с описанием heavy intensity rain

	${result}			    Get Citys With Rain In 5days
	Run Keyword If			len(${result}) > 0	 	Log dictionary		${result}
	Run Keyword Unless		len(${result}) > 0 		Log 		Отсутствие городов, в которых хотя бы в один из дней будет дождь с описанием heavy intensity rain
