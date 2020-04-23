import pyowm
import codecs
import json


def reader():
    readers = codecs.open("D:/Tasks/city.list.json", "r", "utf_8_sig")
    file = json.load(readers)[2400:2500]
    city_ids = []
    for i in file:
        city_ids.append(i["id"])
    return city_ids


def cloudy():
    city_cloud = dict()
    cities_ids = reader()
    for i in cities_ids:
        w_list = pyowm.OWM(API_key='c721de289e2a80513300eae8ebc89ebc').three_hours_forecast_at_id(i)
        weather = w_list.get_forecast().get_weathers()
        for j in weather:
            t = j.get_reference_time(timeformat='date')
            if j.get_clouds() > 90:
                city_cloud[w_list.get_forecast().get_location().get_name() + '  ' + str(t)] = str(j.get_clouds()) + '%'
    return city_cloud


def rainy():
    city_rain = dict()
    cities_ids = reader()
    for i in cities_ids:
        w_list = pyowm.OWM(API_key='c721de289e2a80513300eae8ebc89ebc').three_hours_forecast_at_id(i)
        weather = w_list.get_forecast().get_weathers()
        for j in weather:
            t = j.get_reference_time(timeformat='date')
            if j.get_detailed_status() == 'heavy intensity rain':
                city_rain[w_list.get_forecast().get_location().get_name() + ':date ' + str(t)] = 'heavy intensity rain'
    return city_rain




