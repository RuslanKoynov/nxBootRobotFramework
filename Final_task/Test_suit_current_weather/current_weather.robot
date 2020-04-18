*** Settings ***
Documentation    Test current weather API   #description of test case
Resource     ./resource.robot




*** Test Cases ***
City And Temperature
    [Documentation]    Get a list of cities with temperatures above 25 Celsius
    [Tags]  temperature
    ${result}    ${status} =  get temp and city    # получаем список и статус
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}    # если статус равен 1, данные получены
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!

Day Length
    [Documentation]    Get a list of cities with day length > 12 hours
    [Tags]  sun day
    ${result}    ${status} =  get day length
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!

Fly Conditions
    [Documentation]    Get a list of cities with good fly conditions
    [Tags]  fly
    ${result}    ${status} =  get fly condition
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!

Cities With Snow
    [Documentation]    Get a list of cities with snow
    [Tags]  snow
    ${result}    ${status} =  get cities with snow
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found with snow!

Humidity And Pressure
    [Documentation]    Get a list of cities with humidity and pressure by comndition
    [Tags]  humiditi, pressure
    ${result}    ${status} =  get humidity and pressure
    Run Keyword If    '${status}' == '1'    log dictionary    ${result}
    Run Keyword Unless    '${status}' == '1'    Fail    No cities found by condition!