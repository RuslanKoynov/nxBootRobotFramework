import time
import json
import requests
from requests.adapters import HTTPAdapter

weatherToken = 'fe6ab7439a556a44a31026720c921ee2'

openweather_adapter = HTTPAdapter( max_retries = 3 )
session = requests.Session()
session.mount('https://api.openweathermap.org', openweather_adapter)

def list_of_cities():  # Функция для получения списка из 200 городов
    city_list = []
    with open("C:/Final_task/Current_weather/city.list.json", "r", encoding = 'utf-8') as read_file:
        data = json.load(read_file)[-200:]  # получаем 100 последних городов из списка
    for i in data:
        city_list.append(i["name"])  # из файла получаем список имен городов
    return city_list

def get_temp( city_name ): # Функция выполняет запрос к API и возвращает информацию о температуре в заданном городе
    url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    temp = resp['main']['temp']
    return temp

def get_day_length( city_name ): # Функция выполняет запрос к API и возвращает разность времени заката и восхода
    url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    sunrise_time = resp['sys']['sunrise']
    sunset_time = resp['sys']['sunset']

    day_length_time = sunset_time - sunrise_time
    return day_length_time

def get_fly_condition( city_name ): # Функция выполняет запрос к API и возвращает разность данные о ветре и видимости
    url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    if "visibility" in resp: # проверка наличия поля visibility в ответе
        visibility = resp['visibility']
    else:
        visibility = -1
    wind_speed = resp['wind']['speed']
    return visibility, wind_speed

def get_weather_condition( city_name ): # Функция выполняет запрос к API и возвращает данные о погоде
    url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    weather_condition = resp['weather'][0]['main']
    return weather_condition

def get_humidity_and_pressure( city_name ): # Функция выполняет запрос к API и возвращает разность данные о давлении и влажности
    url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    humidity = resp['main']['humidity']
    pressure = resp['main']['pressure']
    return humidity, pressure