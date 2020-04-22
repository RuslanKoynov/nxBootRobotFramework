import pyowm
import json

owm = pyowm.OWM('there was my key')

def api_func():

    with open("D:/Bootcamp/Robot/Final Task/city.list.json", "r", encoding='utf-8') as read_file:
        data = json.load(read_file)[:200] 
        
    city_id = []  # список с индексами городов
    curr_weather = []  # список с текущей погодой
    count = 0
    
    for i in data:
        city_id.append(i["id"])  # формируем список индексов городов
        
    while count < len(data):
        curr_weather = curr_weather + owm.weather_at_ids(city_id[count:(count + 20)])  # заполняем список с текущей погодой по городам
        count = count + 20
        
    return curr_weather

def get_temp():

    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса

    temperature = 25  # температура, градус Цельсия
    
    for i in id_tmp:
        temp = i.get_weather().get_temperature(unit='celsius')['temp']
        if temp > temperature:
            city_name[i.get_location().get_name()] = temp
            
    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag

def get_daylight():

    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса

    day_length = 43200  # длина светового дня, сек
    
    for i in id_tmp:
        sunset = i.get_weather().get_sunset_time(timeformat='iso')
        sunrise = i.get_weather().get_sunrise_time(timeformat='iso')
        
        sunset_seconds = int(sunset[17:19])
        sunset_minutes = int(sunset[14:16])
        sunset_hours = int(sunset[11:13])
        
        sunrise_seconds = int(sunrise[17:19])
        sunrise_minutes = int(sunrise[14:16])
        sunrise_hours = int(sunrise[11:13])
        
        sunset_summ = sunset_seconds + sunset_minutes * 60 + sunset_hours * 3600
        sunrise_summ = sunrise_seconds + sunrise_minutes * 60 + sunrise_hours * 3600
        
        daylight = sunset_summ - sunrise_summ
        if daylight > day_length:
            city_name[i.get_location().get_name()] = daylight
            
    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag

def get_airport():

    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса

    visibility = 300  # видимость, м
    wind_speed = 20  # скорость ветра, м/с
    
    for i in id_tmp:
        wind = i.get_weather().get_wind('meters_sec')['speed']
        vision = i.get_weather().get_visibility_distance()
        if not vision:
            continue
        if (wind < wind_speed) and (vision > visibility):
            city_name[i.get_location().get_name()] = 'Good conditions'
            
    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag

def get_snow_weather():
    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса
    
    for i in id_tmp:
        snowing = i.get_weather().get_snow()
        if snowing:
            city_name[i.get_location().get_name()] = 'Snow'
            
    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag

def get_humidity_and_pressure():

    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса

    humidity = 75  # отн. влажность, %
    pressure = 770  # атмосферное давление, мм рт.ст.
    
    for i in id_tmp:
        humid = i.get_weather().get_humidity()
        press = i.get_weather().get_pressure()['press']
        if (humid > humidity) and (press > pressure):
            city_name[i.get_location().get_name()] = str(humid) + '%, ' + str(press)
            
    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag