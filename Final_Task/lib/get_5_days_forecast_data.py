import time
import json
import requests
from requests.exceptions import Timeout

def parse_response(json_data):
    '''Функция формирует словарь из переlанного ей ответа от API для одного города'''
    forecast_dict = {"city" : json_data["city"]["name"]}
    five_day_forecast = []
    for forecast in json_data["list"]:
        five_day_forecast.append({"time" : forecast["dt"],
                                  "clouds_percent" : forecast["clouds"]["all"],
                                  "weather_description" : forecast["weather"][0]["description"],
                                  "temp_max" : forecast["main"]["temp_max"],
                                  "temp_min" : forecast["main"]["temp_min"]})
    forecast_dict.update({"main" : five_day_forecast})
    return forecast_dict

def get_forecast_data():
    '''Функция выполняет запрос к API и возвращает список прогнозов погоды для каждого города'''
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp_final\\Final_Task\\lib\\city.list.json", "r", encoding='utf-8') as read_file:
        # Получение первых 200 городов из json файла
        json_data = json.load(read_file)[0:200] 
    request_link = "http://api.openweathermap.org/data/2.5/forecast?"
    my_key = '5516adb39c8abf41d0c938097a48a2a4'
    list_of_forecasts = []
    for city in json_data:
        for i in range(3):
            try:
                #Выполнение запроса
                res = requests.get(request_link,
                                   params={'id':city["id"], 'appid': my_key, 'units':'metric'},
                                   timeout=5)
            except Timeout:
                # Возникло исключение Timeout
                time.sleep(5)
                if i == 3:
                    #Если совершено 3 повторных запроса, то тест не пройден
                    return 'timeout'
                continue
            else:
                res_json = res.json()
                if res_json["cod"] == 400:
                    # Если код ответа 400, то повторить попытку
                    continue
                # Добавление в список прогнозов прогноза для одного города
                list_of_forecasts.append(parse_response(res_json))
                break
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp\\owm_tests\\lib\\forecast.json", "w") as write_file:
        # Запись списка в json файл
        json.dump(list_of_forecasts, write_file)

get_forecast_data_result = get_forecast_data() 