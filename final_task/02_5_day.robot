# -*- coding: utf-8 -*-
*** Settings ***
Documentation    5 day / 3 hour weather forecast
Force Tags    open weather
Default Tags    weather test
Resource    resource.robot

*** Test Cases ***
TC6_cloudiness
    [Documentation]    Searching for a city with cloudiness more than 90%; if none then failed
    [Tags]    cloudiness
    ${cities}=    get cloudiness
    ${info}=    get from dictionary    ${cities}    info
    ${city}=    get from dictionary    ${cities}    City
    ${length}=    get length    ${info}
    Run Keyword Unless    ${length} == 0    Run Keywords    log     ${city}    AND    log list    ${info}
    Run Keyword If    ${length} == 0    Fail    No cities found

TC7_rain
    [Documentation]    Searching for a city with heavy intensity rain; if none then failed
    [Tags]    rain
    ${cities}=    get rain
    ${info}=    get from dictionary    ${cities}    info
    ${city}=    get from dictionary    ${cities}    City
    ${length}=    get length    ${info}
    Run Keyword Unless    ${length} == 0    Run Keywords    log     ${city}    AND    log list    ${info}
    Run Keyword If    ${length} == 0    Fail    No cities found

TC8_difference
    [Documentation]    Searching for a city with difference between morning temperature and day temperature more than 10 Celsius; if none then failed
    [Tags]    temperature difference
    ${cities}=    get difference
    ${info}=    get from dictionary    ${cities}    info
    ${city}=    get from dictionary    ${cities}    City
    ${length}=    get length    ${info}
    Run Keyword Unless    ${length} == 0    Run Keywords    log     ${city}    AND    log list    ${info}
    Run Keyword If    ${length} == 0    Fail    No cities found

*** Keywords ***
Provided precondition
    Setup system under test