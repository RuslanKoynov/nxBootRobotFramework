***Settings***
Documentation   Nexy Task Manager Tests
Library     OperatingSystem
Library     RequestsLibrary
Suite Setup    Clear Database

***Keywords***
Clear Database
    create session    AppAccess    ${base url}
    ${response}    Delete Request    AppAccess    /db
    Should Be Equal    ${response.status_code}   ${204}

***Variables***
${base url}     http://localhost:5001
