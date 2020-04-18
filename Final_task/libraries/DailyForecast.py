import pyowm
import json
import Conf
import time


owm = pyowm.OWM(Conf.weatherToken)


def parse_daily_forecast_for_clouds(id_list):
    pair = dict()
    status = 1
    max_cloud = 90

    for i in id_list:
        observation = owm.three_hours_forecast_at_id(i)
        count = 0  # счетчик
        list_tmp = observation.get_forecast().get_weathers() # получаем 5-ти дневный прогноз с интервалами в 3 часа
        city = observation.get_forecast().get_location().get_name()
        for weather in list_tmp: # проходим по всему прогнозу для одного города
            d = weather.get_clouds()
            weather_status = weather.get_detailed_status()
            time = weather.get_reference_time(timeformat='date')
            if d > max_cloud:
                pair[city + ':date '+ str(time)] = 'Clouds chance: ' + str(d) + '% ' + weather_status
                count +=1
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def cloud_forecast():
    id_list = [536203, 524894, 472757, 7596769, 7891280] # список id городов
    return(parse_daily_forecast_for_clouds(id_list))


def parse_daily_forecast_for_rain(id_list):
    pair = dict()
    status = 1

    for i in id_list:
        observation = owm.three_hours_forecast_at_id(i)
        count = 0  # счетчик
        list_tmp = observation.get_forecast().get_weathers()
        city = observation.get_forecast().get_location().get_name()
        for weather in list_tmp:
            time = weather.get_reference_time(timeformat='date')
            rain_status = weather.get_detailed_status()
            if rain_status == 'heavy intensity rain':
                pair[city + ':date '+ str(time)] = 'Rain: ' + str(rain_status)
                count +=1
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def rain_forecast():
    id_list = [536203, 524894, 472757, 7596769, 7891280] #список id городов
    return(parse_daily_forecast_for_rain(id_list))


def parse_daily_forecast_for_difference(id_list):
    pair = dict()
    status = 1

    for i in id_list:
        observation = owm.three_hours_forecast_at_id(i)
        i = 0
        list_tmp = observation.get_forecast().get_weathers()
        city = observation.get_forecast().get_location().get_name()
        while i < len(list_tmp):
            if i+1 >= len(list_tmp): # выходим из цикла когда дошли до конца списка с пронозом
                break
            time = list_tmp[i].get_reference_time(timeformat='iso')[:-12]  # узнаем текущую дату
            time_next = list_tmp[i+1].get_reference_time(timeformat='iso')[:-12] # узнаем следущую дату по списку
            if time != time_next: # если это разные дни то инкрементируем счетчик
                i +=1
            else:
                while list_tmp[i].get_reference_time(timeformat='iso')[:-12] == list_tmp[i+1].get_reference_time(timeformat='iso')[:-12]: # если день один и тот же
                    current_temp = int(list_tmp[i].get_temperature(unit='celsius')['temp']) # получаем текущую температуру
                    next_temp = int(list_tmp[i+1].get_temperature(unit='celsius')['temp']) # получаем температуру через 3 часа
                    difference = next_temp - current_temp # вычисляем разницу температуры
                    if difference > 10:
                        pair[city + ':date ' + str(time)] = 'Difference: ' + str(difference) # если разница больше 10, записываем в словарь
                    i +=1
                    if i+1 >= len(list_tmp):
                        break
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def difference_temperature_forecast():
    id_list = [536203, 524894, 472757, 7596769, 7891280] #список id городов
    return(parse_daily_forecast_for_difference(id_list))

