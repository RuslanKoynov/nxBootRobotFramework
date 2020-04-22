*** Settings ***
Documentation    Daily Forecast Task
Resource     ./resource.robot


*** Test Cases ***
Cloudy Weather
    [Documentation]    Города, где облачность выше 90%
    [Tags]  clouds
    ${result}    ${flag} =  get cloudy weather
    Run Keyword If    '${flag}' == 'True'    Log Dictionary    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Облачности >90% нигде не наблюдается. 
	
Heavy Intensity Rain
    [Documentation]    Города, где идёт сильный дождь
    [Tags]  heavy rain
    ${result}    ${flag} =  get rainy weather  
    Run Keyword If    '${flag}' == 'True'    Log Dictionary    ${result}
    Run Keyword If    '${flag}' == 'False'		Fail    Сейчас нигде не идёт проливной дождь.
