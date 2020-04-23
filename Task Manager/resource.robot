*** Settings ***
Documentation  Библиотеки
Library  SeleniumLibrary
Library  OperatingSystem
Library  Collections
Library  Process


*** Variables ***
${site}		http://localhost:3000
${browser}	chrome
${task_name}    First Task
${start_date}   23042020
${end_date}     23042020
${description}  The task's desc

*** Keywords ***
Open Brows
  Open Browser  ${site}   ${browser}

