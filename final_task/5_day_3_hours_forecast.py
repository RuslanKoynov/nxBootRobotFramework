import pyowm
import json

api_key = 'a0529df520ec195c2f2c28b653271404'
owm = pyowm.OWM(api_key)

def api_list_of_citys_2():
	with open("D:/Robot/final_task/city.list.json", "r", encoding='utf-8') as read_file:
		json_object = json.load(read_file)[0:30]
	list_of_citys_id = []
	for city_id in json_object:
		list_of_citys_id.append(city_id["id"])
	return list_of_citys_id

def get_citys_with_cloud_in_5days():
	list_of_citys = api_list_of_citys_2()
	check_clouds = 90
	citys_with_cloud_in_5days = dict()
	for i in list_of_citys:
		weather_list_3hours = owm.three_hours_forecast_at_id(i)
		weather_fd = weather_list_3hours.get_forecast().get_weathers()
		for j in weather_fd:
			date = j.get_reference_time(timeformat='date')
			if j.get_clouds() > check_clouds:
				citys_with_cloud_in_5days[weather_list_3hours.get_forecast().get_location().get_name() + " Clouds - " + str(j.get_clouds()) + "%, date - " + str(date)] = ""
	return citys_with_cloud_in_5days
	
def get_citys_with_rain_in_5days():
	list_of_citys = api_list_of_citys_2()
	check_rain = 'heavy intensity rain'
	citys_with_rain_in_5days = dict()
	for i in list_of_citys:
		weather_list_3hours = owm.three_hours_forecast_at_id(i)
		weather_fd = weather_list_3hours.get_forecast().get_weathers()
		for j in weather_fd:
			date = j.get_reference_time(timeformat='date')
			if j.get_detailed_status() == check_rain:
				citys_with_rain_in_5days[weather_list_3hours.get_forecast().get_location().get_name() + " Heavy intensity rain - " + str(date)] = ""
	return citys_with_rain_in_5days
