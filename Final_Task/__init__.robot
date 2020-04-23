***Settings***
Documentation   Final task
Suite Setup     Setup File
Library     OperatingSystem
Suite Teardown    Clean Up Lib Directory


***Keywords***
Setup File
    Create File     results.log

Clean Up Lib Directory
    Remove File  ${CURDIR}${/}lib${/}current_weather.json
    Remove File  ${CURDIR}${/}lib${/}forecast.json

