*** Settings ***
Documentation    Testing https://openweathermap.org 16/daily forecast  #description of test case
Resource     .${/}resource.robot
Force Tags    final task
Test Timeout    2 minutes
Metadata    User    ${USER}

