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
    with open("C:/Final_task/Forecast/city.list.json", "r", encoding = 'utf-8') as read_file:
        data = json.load(read_file)[-200:]
    for i in data:
        city_list.append(i["name"])
    return city_list

def get_clouds_forecast( city_name ):  # Функция выполняет запрос к API и возвращает информацию об облачности в заданном городе если она >90%
    url = 'https://api.openweathermap.org/data/2.5/forecast?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    data = ''
    flag = 0
    for item in resp['list']:
        if item['clouds']['all'] > 90:
            data = data + '\nCity - '+ city_name + '. Clouds - ' + str(item['clouds']['all']) + ', date - ' + str(item['dt_txt'])
            flag = 1
    return data, flag

def get_rain_forecast( city_name ): # Функция выполняет запрос к API и возвращает информацию наличии дождя в заданном городе если он есть
    url = 'https://api.openweathermap.org/data/2.5/forecast?q=' + city_name + '&units=metric&appid=' + weatherToken
    response = session.get(url, timeout = 5)
    resp = response.json()
    data = ''
    flag = 0
    for item in resp['list']:
        if item['weather'][0]['main'] == 'Rain' and item['weather'][0]['description'] == 'heavy intensity rain':
            data = data + '\nCity - '+ city_name + 'Heavy intensity rain - ' + str(item['dt_txt'])
            flag = 1
    return data, flag