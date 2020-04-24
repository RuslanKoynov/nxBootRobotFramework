*** Settings ***
Library    OperatingSystem
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String
Library    DateTime


*** Variable ***
${Key}                  eea55dcc9b60f6042c69727bd8595ee8
${Base_URL}             http://api.openweathermap.org/data/2.5
${result}=              0


*** Keywords ***
get id
        ${contents}=  Get File  .${/}city_id.txt
        @{lines}=   Split to lines  ${contents}
        @{lines}=   set variable  ${lines}[:200]
        [return]     @{lines}


