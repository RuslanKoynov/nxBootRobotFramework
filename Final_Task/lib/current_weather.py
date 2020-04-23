import json
from unix_to_iso import get_hours_minutes_seconds
from get_current_weather_data import get_weather_data

def read_json_file():
    '''Функция чтения json файла с данными о погоде'''
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp_final\\Final_Task\\lib\\current_weather.json", "r", encoding='utf-8') as read_file:
        weather_data_json = json.load(read_file)
    return weather_data_json
    
def check_if_above_25_degrees(requets_result):
    '''Функция для поиска городов с температурой выше 25 градусов Цельсия'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    weather_data_json = read_json_file()
    list_of_results = []
    for element in weather_data_json:
        #Сравнение полученной температуры с заданной по условию
        if element["temperature"] > 25:
            list_of_results.append([element["city"], element["temperature"]])
    if len(list_of_results) == 0:
        # Если список пуст, то тест не пройден
        return None
    else:
        return list_of_results

def check_daytime(requets_result):
    '''Функция для поиска городов с продолжительностью дня больше 12 часов'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    weather_data_json = read_json_file()
    # Перевод 12 часов в секунды
    twelve_hours = 12 * 60 * 60
    list_of_results = []
    for element in weather_data_json:
        if element["daytime"] > twelve_hours:
            list_of_results.append([element["city"], get_hours_minutes_seconds(element["daytime"])])
    if len(list_of_results) == 0:
        # Если список пуст, то тест не пройден
        return None
    else:
        return list_of_results
        
def check_flight_conditions(requets_result):
    '''Функция для поиска городов с подходящими условиями для полётов'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    weather_data_json = read_json_file()
    list_of_results = []
    #Значения для видимости и скорости ветра по условию
    good_visibility = 300
    good_wind_speed = 20
    for element in weather_data_json:
        if element["visibility"] > good_visibility and element["wind speed"] < good_wind_speed:
            list_of_results.append(element["city"])
    if len(list_of_results) == 0:
        # Если список пуст, то тест не пройден
        return None
    else:
        return list_of_results

def check_current_weather(requets_result):
    '''Функция для поиска городов с типом погоды Snow'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    weather_data_json = read_json_file()
    list_of_results = []
    for element in weather_data_json:
        if element["weather"] == "Snow":
            list_of_results.append(element["city"])
    if len(list_of_results) == 0:
        # Если список пуст, то тест не пройден
        return None
    else:
        return list_of_results

def check_humidity_and_pressure(requets_result):
    '''Функция для поиска городов, в которых влажность воздуха больше 75%, а давление выше 770 мм.рт.ст.'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    weather_data_json = read_json_file()
    list_of_results = []
    for element in weather_data_json:
        #Сравнение полученной влажности и давления с заданными по условию
        if element["humidity"] > 75 and element["pressure"] > 770:
            list_of_results.append([element["city"], element["humidity"], element["pressure"]])
    if len(list_of_results) == 0:
        # Если список пуст, то тест не пройден
        return None
    else:
        return list_of_results