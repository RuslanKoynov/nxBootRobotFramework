import pyowm
import json

owm = pyowm.OWM('0596f0b671b754ab17f3c27d0547928b')


def api_func():
    with open("D:/Bootcamp/Robot/Final Task/city.list.json", "r", encoding='utf-8') as read_file:
        data = json.load(read_file)[5000:5100]

    city_id = []  # список с индексами городов

    for i in data:
        city_id.append(i["id"])  # формируем список индексов городов

    return city_id


def get_cloudy_weather():
    city_name = dict()
    flag = True
    id_tmp = api_func()  # вызов функции запроса

    cloudiness = 90  # облачность, %

    for i in id_tmp:
        list_tmp = owm.three_hours_forecast_at_id(i).get_forecast().get_weathers()
        city = owm.three_hours_forecast_at_id(i).get_forecast().get_location().get_name()
        for j in list_tmp:
            clouds = j.get_clouds()
            clouds_date = j.get_reference_time(timeformat='date')
            if clouds > cloudiness:
                city_name[city + ', date: ' + str(clouds_date)] = ', clouds amount: ' + str(clouds) + '% '

    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag


def get_rainy_weather():
    city_name = dict()  # будущий список городов
    flag = True  # флаг
    id_tmp = api_func()  # вызов функции запроса

    for i in id_tmp:
        list_tmp = owm.three_hours_forecast_at_id(i).get_forecast().get_weathers()
        city = owm.three_hours_forecast_at_id(i).get_forecast().get_location().get_name()
        for j in list_tmp:
            rain = j.get_rain()
            rain_date = j.get_reference_time(timeformat='date')
            if rain == 'heavy intensity rain':
                city_name[city + ', date: ' + str(rain_date)] = ', rain status: ' + str(rain)

    if city_name:
        return city_name, flag
    else:
        flag = False
        return city_name, flag
