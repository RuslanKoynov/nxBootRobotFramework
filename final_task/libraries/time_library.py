""" Библиотеку, которая преобразует дату из формата Unix/UTC в формат ISO 8601 вида 2007-0301T13:00:00+03:00.
    Реализована для дат, идущих после начала эпохи Unix"""

leap_month = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
normal_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def isotime(time):
    time = int(time)
    if time >= 0:
        dif_year = time // 31557600  # делим на среднее количество секунд в году
        year = dif_year + 1970       # к полученному году прибавляем год начала эпохи Unix

        simple_year = dif_year % 4   # считаем количество невисокосных лет, не попавших в високосный цикл в найденный промежуток времени
        # года из високосного цикла умножаем на среднее колво секунд в году,
        # а невисокосные года на количество секунд в обычном году соответственно
        # вычитаем полученное число из общего времени, чтоб получить оставшееся количество секунд
        seconds = time - ((dif_year - simple_year) * 31557600 + simple_year * 31536000)
        days = seconds // (24 * 60 * 60)  # получаем количество прошедших дней в текущем году
        days += 1  # + текущий день

        month = 1  # вычисляем номер месяца в цикле
        if year % 4 == 0 and not (year % 4 == 0 and year % 100 == 0 and year % 400 != 0):  # если год високосный
            for i in range(12):
                if days > leap_month[i]:  # если общее количество дней больше количества дней в месяце
                    days = days - leap_month[i]  # вычитаем количество дней в месяце
                    month += 1  # переходим на следующий месяц
        else:
            for i in range(12):
                if days > normal_month[i]:
                    days = days - normal_month[i]
                    month += 1

        seconds = seconds % (24 * 60 * 60)  # вычисляем количество оставшихся секунд
        hours = seconds // (60 * 60)        # вычисляем часы
        seconds = seconds % (60 * 60)       # вычисляем количество оставшихся секунд
        minutes = seconds // 60             # вычисляем часы
        seconds = seconds % 60              # вычисляем количество оставшихся секунд


    if month < 10:
        month = "0{}".format(month)
    if days < 10:
        days = "0{}".format(days)
    if hours < 10:
        hours = "0{}".format(hours)
    if minutes < 10:
        minutes = "0{}".format(minutes)
    if seconds < 10:
        seconds = "0{}".format(seconds)

    date = f"{year}-{month}-{days}T{hours}:{minutes}:{seconds}+03:00"
    date = date.encode("utf8")
    return date



