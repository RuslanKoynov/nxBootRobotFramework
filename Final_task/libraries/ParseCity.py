import pyowm
import json
import Conf
import time


owm = pyowm.OWM(Conf.weatherToken)


def parse_city():
    with open("/home/ricknash/PycharmProjects/Nexign_cource/Final_task/libraries/city.list.json", "r") as read_file:
        data = json.load(read_file)[-200:]  # получаем 100 последних городов из списка
    id_list = []  # лист для хранения id городов
    list_tmp = []
    count = 0  # счетчик
    for i in data:
        id_list.append(i["id"])  # из файла получаем список id городов
    while count < len(data):
        list_tmp += owm.weather_at_ids(id_list[count:(count + 20)])
        count += 20
        time.sleep(5)
    return list_tmp


def get_temp_and_city():
    temperature = 25.0  # температура для сравнения
    pair = dict()  # словарь для города и температуры
    status = 1  # переменная флажок
    list_tmp = parse_city() # вызов функции, осуществляющей API запрос
    for i in list_tmp:
        w = i.get_weather().get_temperature(unit='celsius')['temp'] # температура в цельсиях
        if w > temperature:
            pair[i.get_location().get_name()] = w # заполняем словарь
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def get_day_length():
    condition = 43200 # 12 часов в секундах
    pair = dict()  # словарь
    status = 1  # переменная флажок
    list_tmp = parse_city()

    for i in list_tmp:
        sunset_time = i.get_weather().get_sunset_time(timeformat='iso')
        sunrise_time = i.get_weather().get_sunrise_time(timeformat='iso')

        sunset_sec = int(sunset_time[-5:-3])  # слайсим полученное время
        sunset_min = int(sunset_time[-8:-6])
        sunset_hour = int(sunset_time[-11:-9])

        sunrise_sec = int(sunrise_time[-5:-3])
        sunrise_min = int(sunrise_time[-8:-6])
        sunrise_hour = int(sunrise_time[-11:-9])

        seconds_sunset = sunset_hour * 3600 + sunset_min * 60 + sunset_sec # переводим в секунды
        seconds_sunrise = sunrise_hour * 3600 + sunrise_min * 60 + sunrise_sec
        day_length = seconds_sunset - seconds_sunrise # получаем количество секунд от восхода до заката

        if day_length > condition:
            day_length_time = str('{:02}:{:02}:{:02}'.format(day_length // 3600 % 24, day_length % 3600 // 60, day_length % 3600 % 60))
            pair[i.get_location().get_name()] = day_length_time
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def get_fly_condition():
    condition_visibility = 300
    condition_wind_speed = 20
    pair = dict()  # словарь
    status = 1  # переменная флажок
    list_tmp = parse_city()

    for i in list_tmp:
        wind_speed = i.get_weather().get_wind('meters_sec')['speed']
        visibility = i.get_weather().get_visibility_distance()
        if not visibility:
            continue
        if (wind_speed < condition_wind_speed) and (visibility > condition_visibility):
            pair[i.get_location().get_name()] = 'Good flight conditions but coronavirus!'
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def get_cities_with_snow():
    pair = dict()  # словарь
    status = 1  # переменная флажок
    list_tmp = parse_city()

    for i in list_tmp:
        snow = i.get_weather().get_snow()
        if snow:
            pair[i.get_location().get_name()] = 'Snow!'
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def get_humidity_and_pressure():
    condition_humidity = 75
    condition_pressure = 770
    pair = dict()  # словарь
    status = 1  # переменная флажок
    list_tmp = parse_city()

    for i in list_tmp:
        humidity = i.get_weather().get_humidity()
        pressure = i.get_weather().get_pressure()['press']

        if (humidity > condition_humidity) and (pressure > condition_pressure):
            pair[i.get_location().get_name()] = 'humidity: ' + str(humidity) + '% pressure: ' + str(pressure) + ' мм.рт.ст'
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status
