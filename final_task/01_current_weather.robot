# -*- coding: utf-8 -*-
*** Settings ***
Documentation    Current Weather
Force Tags    open weather
Default Tags    weather test
Resource    resource.robot

*** Test Cases ***
TC1_temperature
    [Documentation]    Searching for a city with temperature above 25.0 Celsius; if none then failed
    [Tags]    temperature
    ${cities}=    get current temperature
    ${length}=    get length    ${cities}
    Run Keyword Unless    ${length} == 0    log dictionary    ${cities}
    Run Keyword If    ${length} == 0    Fail    No cities with given temperature

TC2_daylight
    [Documentation]    Searching for a city with daylight hours more than 12h; if none then failed
    [Tags]    daylight hours
    ${cities}=    get day length
    ${length}=    get length    ${cities}
    Run Keyword Unless    ${length} == 0    log dictionary    ${cities}
    Run Keyword If    ${length} == 0    Fail    No cities with given daylight hours

TC3_conditions
    [Documentation]    Searching for a city with visibility more than 300m and wind speed less than 20mps; if none then failed
    [Tags]    visibility and wind
    ${cities}=    get conditions
    ${city}=    get from dictionary    ${cities}    City
    ${length}=    get length    ${cities}
    Run Keyword Unless    '${city}' == ''    log   City - ${city}. Good conditions.
    Run Keyword If    '${city}' == ''    Fail    No cities with such conditions

TC4_snow
    [Documentation]    Searching for a city where it's snowing; if none then failed
    [Tags]    snow
    ${cities}=    get snow
    ${city}=    get from dictionary    ${cities}    City
    Run Keyword Unless    '${city}' == ''    log  City - ${city}. Snow.
    Run Keyword If    '${city}' == ''    Fail    It's not snowing anywhere

TC5_humidity_pressure
    [Documentation]    Searching for a city with humidity more than 75% and pressusre more than 770 mm Hg, if none then failed
    [Tags]    humidity and pressure
    ${cities}=    get humidity and pressure
    ${length}=    get length    ${cities}
    Run Keyword Unless    ${length} == 0    log dictionary     ${cities}
    Run Keyword If    ${length} == 0    Fail    No cities with such conditions

*** Keywords ***
Provided precondition
    Setup system under test