import pyowm
import json
import requests

api_key = 'a0529df520ec195c2f2c28b653271404' #мой api ключ
owm = pyowm.OWM(api_key) 

def api_list_of_citys():
	with open("D:/Robot/final_task/city.list.json", "r", encoding='utf-8') as read_file:
		json_object = json.load(read_file)[0:200] #чтение 200 городов из списка
	#api_link = "http://api.openweathermap.org/data/2.5/weather?"
	#api_key = "a0529df520ec195c2f2c28b653271404"
	list_of_citys_id = []
	result_list = []
	i = 0
	for city_id in json_object:
		list_of_citys_id.append(city_id["id"]) #лист айдишников городов
	while i < len(json_object):
		result_list += owm.weather_at_ids(list_of_citys_id[i:(i+20)]) #лист с погодой 
		i = i + 20
		#while i < 3:
			#response = requests.get(api_link, par={'id':city["id"], 'appid': api_key, timeout = 5}
			#i = i + 1
		#if i == 3:
			#return 0
	return result_list	

def get_temp_from_citys(): #температура больше 25 градусов
	list_of_citys = api_list_of_citys()
	#citys_name = []
	#citys_temperature = []
	citys_name_and_temperature = dict() #итоговый словарь для вывода
	for i in list_of_citys:
		weather_temperature = i.get_weather().get_temperature(unit='celsius')['temp'] #температура в цельсиях у конкртного города из списка
		if weather_temperature > 25.0: #проверка на выполнение условия
			#name = i.get_location().get_name()
			#citys_name += name  
			#citys_temperature += str(weather_temperature)
			citys_name_and_temperature[i.get_location().get_name()] = weather_temperature #заполнение словаря 
#	return citys_name, citys_temperature
	return citys_name_and_temperature

def get_sundaytime(): #проверка на длительность дня больше 12 часов
	list_of_citys = api_list_of_citys()
	check_suntimeday = 43200 #перевод в секунды 
	citys_with_suntimeday_more_12 = dict()
	for i in list_of_citys:
		weather = i.get_weather()
		sunrise_time = weather.get_sunrise_time(timeformat='iso') 
		sunset_time = weather.get_sunset_time(timeformat='iso')
		day_length =(int(sunset_time[11:13])-int(sunrise_time[11:13]))*3600+(int(sunset_time[14:16])-int(sunrise_time[14:16]))*60+int(sunset_time[17:19])-int(sunrise_time[17:19]) #разница времён по часам, минутам, секундам для вычисления длительности светогого дня
		if day_length > check_suntimeday:
			citys_with_suntimeday_more_12[i.get_location().get_name()] = day_length
	return citys_with_suntimeday_more_12

def get_good_fly_airports(): #удовлетворительность аэропортов
	list_of_citys = api_list_of_citys()
	check_visibility = 300
	check_speed_of_wind = 20
	citys_with_good_fly_airports = dict()
	for i in list_of_citys:
		visibility = i.get_weather().get_visibility_distance()
		speed_of_wind = i.get_weather().get_wind('meters_sec')['speed']
		if visibility: #доп проверка на видимость
			if (speed_of_wind < check_speed_of_wind) and (check_visibility < visibility):
				citys_with_good_fly_airports[i.get_location().get_name()] = "Good conditions"
	return citys_with_good_fly_airports
	
def get_city_with_snow(): #проверка на города со снегом
	list_of_citys = api_list_of_citys()
	citys_with_snow = dict()
	for i in list_of_citys:
		if i.get_weather().get_snow():
			citys_with_snow[i.get_location().get_name()] = "Snow"
	return citys_with_snow

def get_vlagnost_and_davlenie(): #проверка на города с давлением и влажностью
	list_of_citys = api_list_of_citys()
	check_vlagnost = 75
	check_davlenie = 770
	citys_with_vlagnost_and_davlenie = dict()
	for i in list_of_citys:
		vlagnost = i.get_weather().get_humidity()
		davlenie = i.get_weather().get_pressure()['press']
		if (check_vlagnost < vlagnost) and (check_davlenie < davlenie):
			citys_with_vlagnost_and_davlenie[i.get_location().get_name()] = "Humidity - " + str(vlagnost) + "% pressure - " + str(davlenie)
	return citys_with_vlagnost_and_davlenie
