*** Settings ***
Library    OperatingSystem    
Library    Collections
Library    String
Library    Telnet
Library    C:/Final_task/libraries/forecast_library.py

*** Variables ***
${USER}    Uliana Popova
@{CITY_LIST}    # список тестируемых городов
${FLAG}         # флаг успешности нахождения города по заданному условию

*** Keywords ***
Create list of cities
    @{CITY_LIST} =    list of cities
    Set suite variable    @{CITY_LIST}

Reset flag
    ${FLAG}=    Set Variable    0
    Set suite variable    ${FLAG}
