*** Settings ***
Documentation	    Автотестирование основной функциональности
Library	            OperatingSystem
Library             Process
Suite Setup         Py And Npm Starting
Suite Teardown      Stopping Processes



*** Keywords ***
Py And Npm Starting
    Start Process        app.py  shell=True  cwd=D:/Nexign/todo-test-master/server
    Start Process        npm start  shell=True  cwd=D:/Nexign/nexy-tasks-manager-master
    sleep                40 seconds
    
    

Stopping Processes
    Terminate Process


