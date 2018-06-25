import json

with open('bump1.json') as f:
    data = json.load(f)

for item in data:
    item["time"] = int(item["time"])
    item["acceZ_raw"] = float(item["acceZ_raw"])
    item["acceY_raw"] = float(item["acceY_raw"])
    item["acceX_raw"] = float(item["acceX_raw"])
    item["acceZ"] = float(item["acceZ"])
    item["acceY"] = float(item["acceY"])
    item["acceX"] = float(item["acceX"])
    item["gpsSpeed"] = float(item["gpsSpeed"])
    item["obdSpeed"] = float(item["obdSpeed"])
    item["lat"] = float(item["lat"])
    item["lon"] = float(item["lon"])


data = sorted(data, key=lambda k: k['time'])


with open('bump1.json', 'w', encoding='utf8') as outfile:
    json.dump(data, outfile, ensure_ascii=False, indent=4)