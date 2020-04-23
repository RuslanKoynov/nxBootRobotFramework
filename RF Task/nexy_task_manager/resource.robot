***Settings***
Documentation   Resourse file for testsuits
Library     OperatingSystem
Library     SeleniumLibrary
Library     String
Library     DateTime

***Variables***
${path}     ${CURDIR}${/}lib
${browser}  chrome
${user}     Kostya_Filippov
${tasks page url}    http://localhost:3000/tasks
${users page url}    http://localhost:3000/users

${Title Text}     css:#root > div > div > main > div > div > h2
${Create Page}     //a[@class="btn btn-sm btn-primary"]
${Create Button}     //button[@class="btn btn-primary"]

***Keywords***
Open Users Page
    Open Browser    ${users page url}   ${browser}

Open Tasks Page
    Open Browser    ${tasks page url}   ${browser}