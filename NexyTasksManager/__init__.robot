*** Settings ***
Documentation       nexy-task-manager
Library             OperatingSystem
Suite Setup         Begin And Create File
Suite Teardown      End And Append File

*** Keywords ***
# these keywords are not awailable from testsuite files
Begin And Create File
    ${time}            Get Time
    Create File        suite_log/log.txt    ${time}${\n}

End And Append File
    ${time}            Get Time
    Append To File     suite_log/log.txt     ${time}



