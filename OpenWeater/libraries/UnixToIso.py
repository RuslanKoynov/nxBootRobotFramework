seconds = 86400 # количество секунд в 1 дне

def get_year(unixtime):
    year = 365 # кол-во дней в году
    leap_year = 366 # кол-во дней в високосном году
    current_year = 1970 # начало время исчесления
    cur_unix = 0 # счетчик по секундам
    tmp_unix = 0 # переменная, хранящая количество секунд на предыдущей итерации
    while 1:
        if cur_unix > unixtime:
            current_year -= 1
            break
        if (current_year % 4 == 0 and current_year % 100 != 0) or current_year % 400 == 0: # проверка високосного года
            tmp_unix = cur_unix  # запоминаем кол-во сек на прошлой итерации
            cur_unix += leap_year * seconds # прибавляем кол-во секунд в високосном году
        else:
            tmp_unix = cur_unix
            cur_unix += year * seconds # прибавляем кол-во секунд в обычном году году
        current_year += 1

    return current_year, unixtime - tmp_unix # возвращаем год и кол-во секунд от начала года


def get_month(current_year, unix):
    mas_year_default = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] # списки месяцев обычного и високосного годов
    mas_year_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    tmp_unix = 0
    tmp_unix_default = 0
    tmp_unix_leap = 0
    cur_month = 1
    for i in range(0, len(mas_year_leap)):
        if (current_year % 4 == 0 and current_year % 100 != 0) or current_year % 400 == 0:
            tmp_unix_leap = tmp_unix # запоминаем предыдущее состояние
            tmp_unix += mas_year_leap[i] * seconds # прибавляем кол-во секунд i-го месяца в списке високосного года
        else:
            tmp_unix_default = tmp_unix
            tmp_unix += mas_year_default[i] * seconds
        cur_month += 1
        if tmp_unix == unix:
            break
        if tmp_unix > unix:
            cur_month -= 1
            break
    if (current_year % 4 == 0 and current_year % 100 != 0) or current_year % 400 == 0:
        result = unix - tmp_unix_leap
    else:
        result = unix - tmp_unix_default

    if tmp_unix == unix:
        result = 0

    return cur_month, result


def get_day(unix):
    tmp_unix = 0
    tmp_unix_cur = 0
    cur_day = 1
    while 1:
        if tmp_unix_cur > unix:
            cur_day -= 1
            break
        tmp_unix = tmp_unix_cur
        tmp_unix_cur += seconds
        cur_day += 1
    return cur_day, unix - tmp_unix

def get_hour(unix):
    cur_hour = 0
    tmp_unix = 0
    tmp_unix_cur = 0
    sec_in_hour = 3600
    while 1:
        if tmp_unix_cur > unix:
            cur_hour -= 1
            break
        tmp_unix = tmp_unix_cur
        tmp_unix_cur += sec_in_hour
        cur_hour += 1
    return cur_hour, unix - tmp_unix

def get_min_and_sec(unix):
    tmp_unix = 0
    tmp_unix_cur = 0
    sec_in_min = 60
    cur_min = 0
    while 1:
        if tmp_unix_cur > unix:
            cur_min -= 1
            break
        tmp_unix = tmp_unix_cur
        tmp_unix_cur += sec_in_min
        cur_min += 1
    return cur_min, unix - tmp_unix


unix_time = 1493117112

s1 = get_year(unix_time)
year = s1[0]

s2 = get_month(s1[0], s1[1])
month = s2[0]

s3 = get_day(s2[1])
day = s3[0]

s4 = get_hour(s3[1])
hour = s4[0]

s5 = get_min_and_sec(s4[1])
minute = s5[0]
second = s5[1]


time_iso = '{}-{:02}-{:02}T{:02}:{:02}:{:02}+03:00'.format(year, month, day, hour, minute, second)
print(time_iso)

# 1587148255   2020-04-17T18:30:55+03:00
# 1109901663   2005-03-04T02:01:03+03:00
# 1493117112   2017-04-25T10:45:12+03:00