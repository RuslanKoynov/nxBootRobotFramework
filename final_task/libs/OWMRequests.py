import datetime
import json
import time

import dateutil.parser
import requests

appid = 'e18da2d3cab65fdc0914cfbdd2f49e67'  # my api key


def open_file():  # open json file with list of cities, get first 200 cities
    with open("D:\\robotfr\\final_task\\city_list.json", encoding='utf-8') as fh:
        cities_list = json.load(fh)[:200]
    return cities_list


def send_req_5day(id): #request to get 5day forecast
    res = requests.get("http://api.openweathermap.org/data/2.5/forecast",
                       params={'id': id, 'units': 'metric', 'APPID': appid}, timeout = 5)
    data = res.json()
    return data


def send_req_current(id): #request to get current weather
    res = requests.get("http://api.openweathermap.org/data/2.5/weather",
                       params={'id': id, 'units': 'metric', 'APPID': appid}, timeout = 5)
    data = res.json()
    return data


# current weather

def get_current_temperature(): #find a city with temperature above 25
    cities_list = open_file()
    cities_dict = {} # dictionary for storing the matching city
    for city in cities_list:
        data = send_req_current(city["id"])
        if data["main"]["temp"] > 25.0: #get temperature (celsius)
            cities_dict['City'] = city["name"]  # assign city name to city key in dictionary
            cities_dict['Temperature'] = data["main"]["temp"]  # assign temperature to temp key in dictionary
            return cities_dict  # if city is found return dictionary
    return cities_dict  # returns empty dictionary if city's not found


def get_day_length(): #get day length
    comparison = 43200  # 12 hours
    cities_list = open_file()
    cities_dict = {}  # dictionary for storing the matching city
    for city in cities_list:
        data = send_req_current(city["id"])
        sunrise = data["sys"]["sunrise"]
        sunrise_iso = datetime.datetime.fromtimestamp(sunrise)  # sunrise time iso 8601
        sunset = data["sys"]["sunset"]
        sunset_iso = datetime.datetime.fromtimestamp(sunset)  # sunset time iso 8601
        tdelta = sunset_iso - sunrise_iso  # count daylight hours %H%M%S
        t = tdelta.total_seconds()  # convert to seconds
        if t > comparison:  # if more than 12
            cities_dict['City'] = city["name"]  # assign city name to city key in dictionary
            cities_dict['Day length'] = str(tdelta)  # assign day length to day length key in dictionary
            return cities_dict
    return cities_dict


def get_conditions():  # find a city with favorable conditions
    given_visibility = 300
    given_speed = 20
    cities_list = open_file()
    cities_dict = {}  # dictionary for storing the matching city
    visibility = 0
    for city in cities_list:
        data = send_req_current(city["id"])
        if ("visibility" in data):
            visibility = data["visibility"]  # get visibility
        speed = data["wind"]["speed"]  # get speed
        if visibility:
            if (visibility > given_visibility) and (speed < given_speed):
                cities_dict['City'] = city["name"]  # assign city name to city key in dictionary
                return cities_dict
            else:
                cities_dict['City'] = ''
    return cities_dict  # returns empty dictionary if city's not found


def get_snow():  # find a city where it's snowing
    cities_list = open_file()
    cities_dict = {}  # dictionary for storing the matching city
    snow = False
    for city in cities_list:
        data = send_req_current(city["id"])
        if ("snow" in data):
            snow = data["snow"]  # if it's snowing
        if (snow):  # if it's snowing
            cities_dict['City'] = city["name"]  # assign city name to city key in dictionary
            return cities_dict
        else:
            cities_dict["City"] = ''
    return cities_dict  # returns empty dictionary if city's not found


def get_humidity_and_pressure():  # find a city with humidity > 75% and pressure > 770 mm Hg
    given_humidity = 75
    given_pressure = 770
    cities_list = open_file()
    cities_dict = {}  # dictionary for storing the matching city
    for city in cities_list:
        data = send_req_current(city["id"])
        humidity = data["main"]["humidity"]  # get humidity
        pressure = data["main"]["pressure"]  # get pressure
        if (humidity) and (pressure):
            if (humidity > given_humidity) and (pressure > given_pressure):
                cities_dict['City'] = city["name"]  # assign city name to city key in dictionary
                cities_dict['humidity'] = humidity  # assign humidity to key in dictionary
                cities_dict['pressure'] = pressure  # assign pressure to key in dictionary
                return cities_dict
    return cities_dict  # returns empty dictionary if city's not found


# 5 day/3 hours weather forecast

def get_cloudiness():
    global cities_dict
    cities_list = open_file()
    flag = False
    info_list = []
    count = 0
    data = False
    for city in cities_list:
        if flag: #if city's found don't search for another
            break
        cities_dict = {} # dictionary for storing the matching city
        data = send_req_5day(city["id"]) #send request to get 5day forecast
        if (data):
            for i in data["list"]:
                info_dict = {}
                if i['clouds']['all'] > 90: #get cloudiness
                    cities_dict["City"] = city["name"]   # assign city name to city key in dictionary
                    info_dict["cloudiness"] = i['clouds']['all']  # assign cloudiness name to key in dictionary
                    timed = i['dt_txt'][0:10] #get date
                    info_dict["date"] = timed
                    if (info_dict not in info_list): #if the info is repeated drop
                        info_list.append(info_dict)
                    flag = True
    cities_dict["info"] = info_list
    if not flag: #if city's not found make dict empty
        cities_dict["City"] = ''
        cities_dict["info"] = []

    return cities_dict


def get_rain():
    global cities_dict
    cities_list = open_file()
    flag = False
    info_list = []
    for city in cities_list:
        if flag: #if city's found don't search for another
            break
        cities_dict = {}
        data = send_req_5day(city["id"]) #send req
        for i in data["list"]:
            info_dict = {}
            if i['weather'][0]['main'] == 'Rain': #if Rain
                if i['weather'][0]['description'] == 'heavy intensity rain': #if heavy intensity rain
                    cities_dict["City"] = city["name"] # assign city name to city key in dictionary
                    info_dict["Heavy intensity rain"] = i['dt_txt'][0:10] #get date
                    if (info_dict not in info_list): #if repeated drop
                        info_list.append(info_dict)
                    flag = True
    cities_dict["info"] = info_list
    if not flag: #if city's not found make dict empty
        cities_dict["City"] = ''
        cities_dict["info"] = []
    return cities_dict


def get_difference():
    global cities_dict
    cities_list = open_file()
    info_list = []
    flag = False
    day_found = True
    for city in cities_list:
        if flag: #if city's found don't search for another
            break
        cities_dict = {}
        data = send_req_5day(city["id"]) #send req
        timezone = datetime.timedelta(seconds=data["city"]["timezone"]) #get timezone
        morning_found = False
        for i in data["list"]:
            info_dict = {}
            time = dateutil.parser.parse(i["dt_txt"]) + timezone #time in this timezone
            if int(time.strftime("%H")) > 6 and int(time.strftime("%H")) < 12: #find morning time
                day_found = False
                morning_found = True
                morning = i["main"]["temp"] #get morning temperature
            if int(time.strftime("%H")) > 12 and int(time.strftime("%H")) < 18 and morning_found: #find day time if morning's found
                if not day_found:
                    day_found = True
                    day = i["main"]["temp"] #get day temperature
                    if day - morning > 10.0:
                        flag = True
                        cities_dict["City"] = city["name"] # assign city name to city key in dictionary
                        info_dict["Temperature difference"] = day - morning #get difference
                        info_dict["date"] = time.strftime("%d/%m/%Y") #get date
                        if (info_dict not in info_list): #if repeated then drop
                            info_list.append(info_dict)
    cities_dict["info"] = info_list
    if not flag: #if city's not found make dict empty
        cities_dict["City"] = ''
        cities_dict["info"] = []
    return cities_dict
