from datetime import datetime
import pytz

def convert_from_unix_to_iso8601(unix_epoch_time):
    '''Функция для перевода времени из формата Unix/UTC в формат ISO 8601'''
    time_zone = pytz.timezone('Europe/Moscow')
    timestamp = datetime.fromtimestamp(unix_epoch_time, time_zone)
    return str(timestamp.isoformat())

def get_hours(unix_epoch_time):
    '''Вспомогательная функция для перевода времени в формате Unix/UTC в часы. Возвращает количество часов и остаток.'''
    seconds_in_hour = 3600 #Количество секунд в часе
    hours = unix_epoch_time // seconds_in_hour
    time_left = unix_epoch_time % seconds_in_hour
    return hours, time_left

def get_minutes_and_seconds(unix_epoch_time):
    '''Вспомогательная функция для перевода времени в формате Unix/UTC в минуты и секунды.'''
    seconds_in_minute = 60 #Количество секунд в минуте
    minutes = unix_epoch_time // seconds_in_minute
    seconds = unix_epoch_time % seconds_in_minute
    return minutes, seconds

def get_hours_minutes_seconds(daytime):
    '''Функция для перевода разницы во времени в формате Unix/UTC в пределах одного дня. Возвращает время в формате 00:00:00'''
    hours, time_left = get_hours(daytime)
    minutes, seconds = get_minutes_and_seconds(time_left)
    return '{:02}:{:02}:{:02}'.format(hours, minutes, seconds)

def get_datetime_object(unix_epoch_time):
    '''Функция, преобразующая время в формате Unix/UTC в объект типа datetime'''
    time_zone = pytz.timezone('Europe/Moscow')
    date = datetime.fromtimestamp(unix_epoch_time, time_zone)
    return date
