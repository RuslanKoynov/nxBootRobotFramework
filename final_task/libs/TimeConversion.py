def add_zero(var): #adds zero in front of number if it's < 10, converts to string
    if var < 10:
        str_var = '0' + str(var)
    else:
        str_var = str(var)
    return str_var

#conversion from unix time to iso 8601
#algorithm is based on a concept of eras; each era has 146097 days or 400 years; eras repeat themselves
def unix_time_conversion(timestamp):
    timestamp_days = int(timestamp / 86400)  # days since epoch
    z = timestamp_days
    z += 719468 #count not from 1970-01-01 but from 0000-03-01; it helps with leap years, era - 0
    if z >= 0:
        era = int(z / 146097) #get era; 1600-03-01 - 2000-02-29 for example is 4th era
    else:
        era = int((z - 146096) / 146097)

    # find the number of the day in the era  [0, 146096]
    day_of_era = z - era * 146097
    # find the year in the era [0, 399]
    year_of_era = int((day_of_era - int(day_of_era / 1460) + int(day_of_era / 36524) - int(day_of_era / 146096)) / 365)
    # get the real year
    y = int(year_of_era) + era * 400
    #find the day in the era year [0, 365]
    day_of_year = int(day_of_era - int(365 * year_of_era + int(year_of_era / 4) - int(year_of_era / 100)))
    #and month [0, 11]
    month_of_year = int(int(5 * day_of_year + 2) / 153)

    if (timestamp >= 0): #if after 1970
        d = int(day_of_year - int((153 * month_of_year + 2) / 5)) + 1 #find the day [1, 31]
        t_seconds = timestamp - timestamp_days * 86400 #count seconds that are left
    else: #if before 1970
        d = int(day_of_year - int((153 * month_of_year + 2) / 5))
        t_seconds = 86400 - abs(timestamp - timestamp_days * 86400)
    # print(d)
    if month_of_year < 10: #since our year starts from March we need to find month according to our calendars [1, 12]
        m = month_of_year + 3
    else:
        m = month_of_year - 9
    if m < 3:
        y += 1
    hour = int(t_seconds / 3600) #get hour from seconds left
    min = int((t_seconds - hour * 3600) / 60) #get minutes from seconds left
    sec = t_seconds - hour * 3600 - min * 60 #get seconds from seconds left
    y = str(y)
    hour = add_zero(hour)
    min = add_zero(min)
    sec = add_zero(sec)
    m = add_zero(m)
    d = add_zero(d)
    str_time = y + '-' + m + '-' + d + 'T' + hour + ':' + min + ':' + sec + '+03:00'
    return str_time

# str_time = unix_time_conversion(54534534)
# print(str_time)