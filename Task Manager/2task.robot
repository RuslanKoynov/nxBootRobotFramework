*** Settings ***
Documentation  Создание задачи
Resource       resource.robot

*** Test Cases ***

Task Creating With Empty Task Name  
   [Setup]              Open Brows 
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${EMPTY}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process     timeout=3 secs
   ${alert} =           Handle Alert
   Page Should Not Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs


Task Creating With Empty Desc   
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${EMPTY}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process     timeout=3 secs
   ${alert} =           Handle Alert
   Page Should Not Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating   
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process      timeout=3 secs
   Page Should Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating With Empty Assignee  
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process     timeout=3 secs
   Page Should Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating Month February  
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=1 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=1 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=1 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=1 secs
   Input Text           name:start_date       01022021
   Wait For Process     timeout=1 secs
   Input Text           name:end_date         01022021
   Wait For Process     timeout=1 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=1 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=1 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process     timeout=3 secs
   Page Should Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Verification February Month
   Wait For Process     timeout=2 secs
   ${dmy}	Get text 	css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(2) > div.card-body > p:nth-child(3)
   Run Keyword If        '${dmy}' == '2021-02-01 - 2021-02-08'     log    Test passes
   Run Keyword Unless    '${dmy}' == '2021-02-01 - 2021-02-08'    Fail    Test fails
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating With Incorrect Description 
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      Темнел московский серый зимний день, холодно зажигался газ в фонарях, тепло освещались витрины магазинов — и разгоралась вечерняя, освобождающаяся от дневных дел московская жизнь: гуще и бодрей неслись извозчичьи санки, тяжелей гремели переполненные, ныряющие трамваи, — в сумраке уже видно было, как с шипением сыпались с проводов зеленые звезды — оживленнее спешили по снежным тротуарам мутно чернеющие прохожие... Каждый вечер мчал меня в этот час на вытягивающемся рысаке мой кучер — от Красных ворот к храму Христа Спасителя: она жила против него; каждый вечер я возил ее обедать в «Прагу», в «Эрмитаж», в «Метрополь», после обеда в театры, на концерты, а там к «Яру», в «Стрельну»... Чем все это должно кончиться, я не знал и старался не думать, не додумывать: было бесполезно — так же, как говорить с ней об этом: она раз навсегда отвела разговоры о нашем будущем; она была загадочна, непонятна для меня, странны были и наши с ней отношения — совсем близки мы все еще не были; и все это без конца держало меня в неразрешающемся напряжении, в мучительном ожидании — и вместе с тем был я несказанно счастлив каждым часом, проведенным возле нее.
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process      timeout=3 secs
   Page Should Not Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating With Empty End Date  
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       ${start_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process      timeout=3 secs
   Page Should Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs

Task Creating With Empty Start Date  
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process      timeout=3 secs
   Page Should Contain   Task has been created
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs


Task Creating With Start Date Earlier Than Current Date 
   Click Element	xpath://*[contains(text(), "Tasks")]
   Wait For Process     timeout=2 secs
   Click Element	xpath://*[contains(text(), "Create")]
   Wait For Process     timeout=2 secs
   Input Text           name:task_name        ${task_name}
   Wait For Process     timeout=2 secs
   Input Text           name:description      ${description}
   Wait For Process     timeout=2 secs
   Input Text           name:start_date       22042021
   Wait For Process     timeout=2 secs
   Input Text           name:end_date         ${end_date}
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='custom-select d-block w-100'] 
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[contains(text(), "Cyle")]
   Wait For Process     timeout=2 secs
   Click Element        xpath://*[@class='btn btn-primary']
   Wait For Process      timeout=3 secs
   Page Should Not Contain   Task has been created
   [Teardown]           Close Browser