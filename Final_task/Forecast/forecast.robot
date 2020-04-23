*** Settings ***
Documentation    Test 5 day weather forecast
Resource         resource.robot
Suite Setup      Create list of cities 
Test Setup       Reset flag

*** Test Cases ***
Cities With Clouds
    [Documentation]    Get a list of cities with clouds over 90%. If there are none, then display the appropriate message.
    [Tags]  clouds
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${data}    ${FLAG}    get clouds forecast    ${city_name} 
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition! 

Cities With Heavy Rain
    [Documentation]    Get a list of cities with heavy rain/ If there are none, then display the appropriate message.
    [Tags]  rain
    : FOR    ${city_name}    IN    @{CITY_LIST}
    \    ${data}    ${FLAG}    get rain forecast    ${city_name} 
    Run Keyword if    '${FLAG}' == '0'    Fail    No cities found by condition! 