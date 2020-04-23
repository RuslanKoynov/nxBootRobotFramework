import json

dict = {}
with open("city.list.json", "r", encoding='utf-8') as file:
    data = json.load(file)

f = open('id.txt', 'w')
for i in range(200):
    dict = data[i]
    f.write(str(dict["id"])+'\n')



