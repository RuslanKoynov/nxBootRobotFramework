import pyowm
import codecs
import json
import time


def api():  # функция выполнения api запроса
    reader = codecs.open("D:/Tasks/city.list.json", "r", "utf_8_sig")
    file = json.load(reader)[2400:2600]
    city_ids = []
    for i in file:
        city_ids.append(i["id"])
    weather_list = []
    for j in range(0, len(file), 20):   # получение городов вместе с погодой
        weather_list += pyowm.OWM(API_key='c721de289e2a80513300eae8ebc89ebc').weather_at_ids(city_ids[j:(j + 20)])
        j += 20
        time.sleep(5)
    return weather_list


def temp25():
    weather_list = api()   # вызываем функцию
    city_temp = dict()
    for i in weather_list:
        temperature = i.get_weather().get_temperature(unit='celsius')['temp']  # got temperature
        if temperature > 25.0:
            city_temp[i.get_location().get_name()] = temperature   # filling dictionary
    return city_temp


def snow():
    weather_list = api()
    city = dict()
    for i in weather_list:
        snowy = i.get_weather().get_snow()
        if snowy:
            city[i.get_location().get_name()] = 'Snowy'
    return city


def vis_speed():
    weather_list = api()
    city = dict()
    for i in weather_list:
        speed = i.get_weather().get_wind('meters_sec')['speed']
        vis = i.get_weather().get_visibility_distance()
        if not vis:
            continue
        if (vis > 300) and (speed < 20):
            city[i.get_location().get_name()] = 'Good conditions'
    return city


def hum_press():
    weather_list = api()
    c_h_p = dict()
    for i in weather_list:
        press = i.get_weather().get_pressure()['press']
        hum = i.get_weather().get_humidity()
        if (hum > 75) and (press > 700):
            c_h_p[i.get_location().get_name()] = str(hum) + ' ' + str(press)
    return c_h_p
