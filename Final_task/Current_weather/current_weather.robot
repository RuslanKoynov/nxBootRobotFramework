*** Settings ***
Documentation    Test current weather API   
Resource         resource.robot
Suite Setup      Create list of cities
Test Setup       Reset flag

*** Test Cases ***
City And Temperature
    [Documentation]    Get City And Temperature
    [Tags]   temperature
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${temp}     get temp    ${city_name}   
    \    Run Keyword if    ${temp} > 25     log    City - ${city_name}, Temperature - ${temp}         
    \    ${FLAG}=    Set Variable If    ${temp} > 25    1    ${FLAG}
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition!  
    
Day Length
    [Documentation]    Get a list of cities with day length > 12 hours (day length > 43200)
    [Tags]  sun day
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${day_length_time}    get day length    ${city_name}   
    \    Run Keyword if  ${day_length_time} > 43200    log    City - ${city_name}, day length - ${day_length_time}
    \    ${FLAG}=    Set Variable If    ${day_length_time} > 43200    1    ${FLAG}
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition!  

Fly Conditions
    [Documentation]    Get a list of cities with good fly conditions (visibility > 300, wind speed < 20)
    [Tags]  fly
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${visibility}    ${wind_speed}    get fly condition    ${city_name}   
    \    Run Keyword If  ${visibility} > 300 and ${wind_speed} < 20    log    City - ${city_name}, good conditions
         ...    ELSE IF    ${visibility} < 0    log    City - ${city_name}, no information about visibility
    \    ${FLAG}=    Set Variable If    ${visibility} > 300 and ${wind_speed} < 20    1    ${FLAG}
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition!  

Cities With Snow
    [Documentation]    Get a list of cities with snow
    [Tags]  snow
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${weather_condition}    get weather condition    ${city_name}   
    \    Run Keyword if  '${weather_condition}' == 'Snow'    log    City - ${city_name}, snow
    \    ${FLAG}=    Set Variable If    '${weather_condition}' == 'Snow'    1    ${FLAG}
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition!  

Humidity And Pressure
    [Documentation]    Get a list of cities with humidity > 75 and pressure > 770
    [Tags]  humiditi, pressure
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${humidity}    ${pressure}    get humidity and pressure    ${city_name}   
    \    Run Keyword if  ${humidity} > 75 and ${pressure} > 770    log    City - ${city_name}. Humidity - ${humidity}, pressure - ${pressure}.
    \    ${FLAG}=    Set Variable If    ${humidity} > 75 and ${pressure} > 770    1    ${FLAG}
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition!