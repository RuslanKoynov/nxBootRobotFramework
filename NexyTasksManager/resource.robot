*** Settings ***
Library    OperatingSystem
Library    Collections
Library    BuiltIn
Library    String
Library    SeleniumLibrary
Library    Screenshot
Library    DateTime
#Process
#Screenshot
#String
#Telnet
#XML

*** Variables ***
${NAME}             Robot Framework
${VERSION}          2.0
${ROBOT}            ${NAME} ${VERSION}  #catenate 2 or more variables
${USER}             Chernousova Sophia
@{NUMBERS}    0   1   2   3   4   5   6   7   8   9
@{LETTER_NUMBERS}   zero   one   two  three   four    five   six   seven   eight   nine

*** Keywords ***

Open Browser To Surf
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window