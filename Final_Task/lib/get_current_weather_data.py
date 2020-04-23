import time
import json
import requests
from requests.exceptions import Timeout
 
def get_weather_data():
    '''Функция выполняет запрос к API и возвращает список данных о погоде для каждого города'''
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp_final\\Final_Task\\lib\\city.list.json", "r", encoding='utf-8') as read_file:
        # Получение первых 200 городов из json файла
        json_data = json.load(read_file)[0:200]
    request_link = "http://api.openweathermap.org/data/2.5/weather?"
    my_key = '5516adb39c8abf41d0c938097a48a2a4'
    list_of_weather = []
    for city in json_data:
        for i in range(3):
            try:
                #Выполнение запроса
                res = requests.get(request_link,
                                   params={'id':city["id"],
                                           'appid': my_key,
                                           'units':'metric'},
                                   timeout=5)
            except Timeout:
                # Возникло исключение Timeout
                time.sleep(5)
                if i == 3:
                    #Если совершено 3 повторных запроса, то тест не пройден
                    return "timeout"
                continue
            else:
                data = res.json()
                if data["cod"] == 400:
                    # Если код ответа 400, то повторить попытку
                    continue
                sunrise_time = data["sys"]["sunrise"]
                sunset_time = data["sys"]["sunset"]
                day_time = sunset_time - sunrise_time
                try:
                    visibility = data["visibility"]
                except KeyError:
                    # Если в ответе нет поля visibility, то оно равно 0
                    visibility = 0
                # Добавление в список прогнозов прогноза для одного города
                list_of_weather.append({"city":data["name"], "temperature":data["main"]["temp"],
                                    "daytime":day_time, "visibility":visibility,
                                    "wind speed":data["wind"]["speed"], "weather":data["weather"][0]["main"],
                                    "humidity":data["main"]["humidity"], "pressure":data["main"]["pressure"]})
                break
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp\\owm_tests\\lib\\current_weather.json", "w") as write_file:
        # Запись списка в json файл
        json.dump(list_of_weather, write_file)

get_weather_data_result = get_weather_data() 