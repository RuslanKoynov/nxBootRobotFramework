***Settings***
Documentation   Resourse file for testsuits
Library     OperatingSystem
Library     String
Library     ${path}/current_weather.py
Library     ${path}/5_days_forecast.py

***Variables***
${path}     ${CURDIR}${/}lib
${error timeout}    Timeout error! No response from server after 3 attempts.

***Keywords***
Append If Failed
    [Arguments]     ${error msg}
    Append To File  results.log     ${error msg}\n
    Fail    ${error msg}

Get Type Of Variable
    [Arguments]    ${variable}
    ${type}    Evaluate    type($variable)
