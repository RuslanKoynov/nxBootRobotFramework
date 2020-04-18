*** Settings ***
Documentation    Testing https://openweathermap.org   #description of test case
Resource     .${/}resource.robot
Force Tags    final task
Test Timeout    2 minutes
Metadata    User    ${USER}

