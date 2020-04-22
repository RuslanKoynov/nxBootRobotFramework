*** Settings ***
Documentation    Testing https://openweathermap.org
Resource     .${/}resource.robot
Force Tags    final task
Test Timeout    2 minutes
Metadata    User    ${USER}