import json
from unix_to_iso import convert_from_unix_to_iso8601, get_datetime_object
from get_5_days_forecast_data import get_forecast_data

def read_json_file():
    '''Функция чтения json файла с прогнозами'''
    with open("C:\\Users\\Pepega\\Desktop\\nx_bootcamp_final\\Final_Task\\lib\\forecast.json", "r", encoding='utf-8') as read_file:
        weather_data_json = json.load(read_file)
    return weather_data_json

def check_clouds_percents(requets_result):
    '''Функция для поиска прогнозов с облачностью выше 90%'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    forecast_data_json = read_json_file()
    list_of_results = []
    for city_forecast in forecast_data_json:
        #просмотр прогнозов для каждого города
        for element in city_forecast["main"]:
            current_clouds_percent = element["clouds_percent"]
            if current_clouds_percent > 90:
                list_of_results.append([city_forecast["city"],
                                        current_clouds_percent,
                                        convert_from_unix_to_iso8601(element["time"])])
    if len(list_of_results) != 0:
        return list_of_results
    # Если список пуст, то тест не пройден
    return None

def check_rain_description(requets_result):
    '''Функция для поиска прогнозов с описанием погоды "heavy intensity rain"'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    forecast_data_json = read_json_file()
    list_of_results = []
    test_description = "heavy intensity rain"
    for city_forecast in forecast_data_json:
        #просмотр прогнозов для каждого города
        for element in city_forecast["main"]:
            current_weather_description = element["weather_description"]
            if current_weather_description == test_description:
                list_of_results.append([city_forecast["city"],
                                        convert_from_unix_to_iso8601(element["time"])])
    if len(list_of_results) != 0:
        return list_of_results
    # Если список пуст, то тест не пройден
    return None
 
def check_temperature_difference(requets_result):
    '''Функция для поиска прогнозов, в которых разница между температурами утром и днем больше 10 градусов Цельсия'''
    if requets_result == "timeout":
        return "Timeout error! No response from server after 3 attempts."
    forecast_data_json = read_json_file()
    list_of_results = []
    for city_forecast in forecast_data_json:
        #просмотр прогнозов для каждого города
        minimum_temperature = None
        maximum_temperature = None
        for element in city_forecast["main"]:
            timestamp = element["time"]
            # Получение данных о дате и времени
            date = get_datetime_object(timestamp)
            current_day = date.day
            current_hour = date.hour
            if current_hour == 6:
                minimum_temperature = element["temp_min"]
            elif current_hour == 12:
                maximum_temperature = element["temp_max"]
                if minimum_temperature is not None:
                    #Вычисление разницы температур
                    temperature_difference = maximum_temperature - minimum_temperature
                    if temperature_difference > 10:
                        list_of_results.append([city_forecast["city"],
                                                temperature_difference,
                                                current_day])
            else: continue
    if len(list_of_results) != 0:
        return list_of_results
    # Если список пуст, то тест не пройден
    return None