*** Settings ***
Documentation    Final tests    #description of test case
Resource     C:\Новая папка\OpenWeater\Test_suit_daily_forecast\resource.robot



*** Test Cases ***
Cities With Clouds
    [Documentation]    Get a list of cities with clouds over 90%
    [Tags]  clouds
    ${result}    ${status} =  cloud forecast
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!

Cities With Heavy Rain
    [Documentation]    Get a list of cities with heavy rain
    [Tags]  rain
    ${result}    ${status} =  rain forecast
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!

Cities With Difference Temperature
    [Documentation]    Get a list of cities with a temperature difference of more than 10 degrees
    [Tags]  difference
    ${result}    ${status} =  difference temperature forecast
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!