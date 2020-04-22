import pyowm
import json
import Conf
import time


owm = pyowm.OWM(Conf.weatherToken)

def parce_daily_forecast_for_clouds():
    pair = dict()
    status = 1
    max_cloud = 90
    with open("/home/ricknash/nxBootRobotFramework/Final_task/libraries/city.list.json", "r") as read_file:
        data = json.load(read_file)[0:30]  # получаем 30
    id_list = []  # лист для хранения id городов
    count = 0  # счетч
    for i in data:
        id_list.append(i["id"])  # из файла получаем список id городов
        print(id_list)
    while count < len(data):
        list_tmp = owm.three_hours_forecast_at_id(id_list[count]).get_forecast()
        count += 1
        city = list_tmp.get_location().get_name()
        print(city)
        for weather in list_tmp: # проходим по всему прогнозу для одного города
            d = weather.get_clouds()
            weather_status = weather.get_detailed_status()
            city_time = weather.get_reference_time(timeformat='date')
            if d > max_cloud:
                pair[city + ':date '+ str(city_time)] = 'Clouds chance: ' + str(d) + '% ' + weather_status
        time.sleep(2)
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def parce_daily_forecast_for_rain():
    pair = dict()
    status = 1

    with open("/home/ricknash/nxBootRobotFramework/Final_task/libraries/city.list.json", "r") as read_file:
        data = json.load(read_file)[0:30]  # получаем 30
    id_list = []  # лист для хранения id городов
    count = 0  # счетч

    for i in data:
        id_list.append(i["id"])  # из файла получаем список id городов
        print(id_list)
    while count < len(data):
        list_tmp = owm.three_hours_forecast_at_id(id_list[count]).get_forecast()
        count += 1
        city = list_tmp.get_location().get_name()
        print(city)
        for weather in list_tmp:
            city_time = weather.get_reference_time(timeformat='date')
            rain_status = weather.get_detailed_status()
            if rain_status == 'heavy intensity rain':
                pair[city + ':date '+ str(city_time)] = 'Rain: ' + str(rain_status)
                count +=1
        time.sleep(2)
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def parce_daily_forecast_for_difference(id_list):
    pair = dict()
    status = 1
    for i in id_list:
        observation = owm.three_hours_forecast_at_id(i)
        i = 0
        list_tmp = observation.get_forecast().get_weathers()
        city = observation.get_forecast().get_location().get_name()
        while i < len(list_tmp):
            if i+3 >= len(list_tmp): # выходим из цикла когда дошли до конца списка с пронозом
                break
            if list_tmp[i].get_reference_time(timeformat='iso')[-11:-3] == '06:00:00':
                time = list_tmp[i].get_reference_time(timeformat='iso')[:-12]  # узнаем текущую дату
                time_next = list_tmp[i+3].get_reference_time(timeformat='iso')[:-12] # узнаем следущую дату по списку
                if time != time_next: # если это разные дни то инкрементируем счетчик
                    i +=1
                else:
                    while list_tmp[i].get_reference_time(timeformat='iso')[:-12] == list_tmp[i+3].get_reference_time(timeformat='iso')[:-12]: # если день один и тот же
                        current_temp = int(list_tmp[i].get_temperature(unit='celsius')['temp']) # получаем текущую температуру
                        next_temp = int(list_tmp[i+3].get_temperature(unit='celsius')['temp']) # получаем температуру через 9 часов
                        difference = next_temp - current_temp # вычисляем разницу температуры
                        if abs(difference) > 10:
                            pair[city + ':date ' + str(time)] = 'Difference: ' + str(difference) # если разница больше 10, записываем в словарь
                        i +=3
                        if i+3 >= len(list_tmp):
                            break
            else:
                i += 1
    if pair:
        return pair, status
    else:
        status = 0
        return pair, status


def difference_temperature_forecast():
    id_list = [833, 2960, 3245, 3530, 5174, 7264, 8084, 9874, 11263, 11754, 12795, 14177, 14256, 18007, 18093, 18557, 18918, 23814, 24851, 29033, 30321, 30485, 30490, 30543, 30616, 30689, 30696, 30714, 30729, 30735]
 #список id городов
    return(parce_daily_forecast_for_difference(id_list))
