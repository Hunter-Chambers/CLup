storeUsername = "Store1"
days = ["day1", "day2", "day3", "day4", "day5", "day6", "day7" ]

for day in days:
    filePath = "./" + day
    with open(filePath, 'w') as f:
            json.dump(data, f, indent=2)

