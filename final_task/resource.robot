*** Settings ***
Library    OperatingSystem
Library    Collections
Library    BuiltIn
Library    String
Library    Selenium2Library
Library    Screenshot
Library    RequestsLibrary
Library    DateTime
Library    JSONLibrary
Library    json
Library    libs/OWMRequests.py
#Process
#Screenshot
#String
#Telnet
#XML

*** Variables ***
${NAME}             Robot Framework
${VERSION}          2.0
${BROWSER}    googlechrome

*** Keywords ***

Open Browser To Surf
    Open Browser    ${URL}    ${BROWSER}

Sleep For A While
    Sleep    4 seconds

