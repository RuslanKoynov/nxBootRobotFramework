*** Settings ***
Library    OperatingSystem    #used library
Library    Collections
Library    String
Library    Telnet
Library    Process
Library    SeleniumLibrary

*** Variables ***
${USER}    Ivan Demidov
${TASKS URL}      http://localhost:3000/tasks
${USERS URL}      http://localhost:3000/users
${BROWSER}        chrome
@{tasks}          1    2    3    4    5    6    7    8
# Переменные для формы добавления задачи
${TASK CREATE BUTTON}    css:#root > div > div > main > div > div.d-flex.justify-content-between.flex-wrap.flex-md-nowrap.align-items-center.pb-2.mb-3 > div > a
${START DATE FIELD}    css:#root > div > div > main > div > form > div:nth-child(3) > div:nth-child(1) > input
${END DATE FIELD}    css:#root > div > div > main > div > form > div:nth-child(3) > div:nth-child(2) > input
${CREATE FORM BUTTON}    css:#root > div > div > main > div > form > button
# Переменные для проверки USER
${USER_TITLE}    css:#root > div > div > main > div > div > h2
${USER_CREATE_BUTTON}    css:#root > div > div > main > div > div > div > a
${CREATE_FORM_USER_BUTTON}    css:#root > div > div > main > div > form > button
# Переменные для проверки объема символов для Description и Tasks name
${SYMBOLS_1001}     Мы сделали плагин, который подсчитывает количество символов и слов в тексте в режиме онлайн, причём отдельно отображается количество символов с пробелами и без пробелов. Такими автоматическими формами пользуются множество людей, в их числе и контент-менеджер нашей компании. Теперь он перестал пользоваться чужими решениями, тем самым подольше остаётся на нашем сайте и поменьше находится на сторонних ресурсах.Через некоторое время мы обнаружили, что наш контент-менеджер обладает повышенным количеством свободного времени и решили поручить ему выполнение дополнительной работы. Это повысило ему заработную плату и помогло уменьшитьнагрузку коллектива вцелом. В итоге счастлив контент-менеджер и радуется вся команда!Для тэговУпустим банальные случаи использования плагина, например, подсчёт слов для объявлений или сообщений, и рассмотрим наиболее популярный случай наших клиентов. Устанавливая на каждый наш сайт систему управления, мы даём возможность нашим клиентам редактировать не только текст, видимый посетителям сайта, но и невидимые для обычного посетителя тэги, которые влияют на ранжирование сайта в поисковых системах. Вот для того, чтобы наилучшим образом написать тэги заголовка, описания и ключевых слов страниц сайта, можно использовать этот плагин и знания оптимального количества символов для каждого из них.
#Переменные для проверки TASKS
${TASK_PAGE_TITLE}    css:#root > div > div > main > div > div.d-flex.justify-content-between.flex-wrap.flex-md-nowrap.align-items-center.pb-2.mb-3 > h2
${TASK_DELETE_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > div > button:nth-child(2)
${TASK_UPDATE_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > div.card-body > div > button:nth-child(1)
${CREATE_TASK_BUTTON}     css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > button
${TASK_UPDATE_DATESTART_BUTTON}    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(3) > div:nth-child(1) > input
${TASK_UPDATE_DATEEND_BUTTON}    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(3) > div:nth-child(2) > input
${TASK_UPDATE_ASSINGNE_BUTTON}    css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(4) > div > select > option:nth-child(6)


*** Keywords ***


Open Tasks Page
    Open Browser    ${TASKS URL}    ${BROWSER}

Open Users Page
    Open Browser    ${USERS URL}    ${BROWSER}

Input Username
    [Arguments]    ${username}
    Input text     name:user_name   ${username}

Input Tasks Name
    [Arguments]    ${tasksname}
    Input text     name:task_name    ${tasksname}

Input Description Name
    [Arguments]    ${descriptionname}
    Input text     name:description    ${descriptionname}

Input Date Start
    [Arguments]    ${datastart}
    Input text     name:start_date    ${datastart}

Input Date End
    [Arguments]    ${datastart}
    Input text     name:end_date    ${datastart}

Select Assign
    [Arguments]    ${number}
    [Return]     css:#root > div > div > main > div > form > div:nth-child(4) > div > select > option:nth-child(${number})

Input Description Update Name
    [Arguments]    ${descriptionupdatename}
    Input text     name:task_description    ${descriptionupdatename}


Input Date Update start
    [Arguments]    ${datastart}
    Input text     name:task_start_date    ${datastart}


Input Date Update End
    [Arguments]    ${datastart}
    Input text     name:task_end_date    ${datastart}

Select Assign Update
    [Arguments]    ${number_assigne}
    [Return]       css:#root > div > div > main > div > div:nth-child(2) > div:nth-child(1) > form > div:nth-child(4) > div > select > option:nth-child(${number_assigne})