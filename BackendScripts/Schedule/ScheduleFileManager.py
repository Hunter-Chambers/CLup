#!/usr/bin/env python3
import json
import os
import sys


os.umask(0)

# store info
state = sys.argv[1]
city = sys.argv[2]
store = sys.argv[3]
address = sys.argv[4]
storeUsername = sys.argv[5]
startTime = sys.argv[6]
endTime = sys.argv[7]

# USE THIS FILEPATH ON THOR
filePath = '/var/www/html/cs4391/hc998658/Schedule'
os.chdir(filePath)
days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" ]

timeHours = int(startTime[0:2])
timeMins = int(startTime[2:])
time = startTime
timeNum = timeHours * 60 + timeMins
endTimeNum = int(endTime[0:2]) * 60 + int(endTime[2:])

data = {}
#################################
shoppingData = {}
#################################
while timeNum < endTimeNum:

    #################################
    shoppingData[time] = {"scheduled": 0, "walk_ins": 0}
    #################################

    data[time] = {"num_reservations":0}

    timeMins += 15
    if timeMins == 60:
        timeMins = 0
        timeHours += 1
    # end if

    # build next time str
    timeHoursStr = str(timeHours)
    if len(timeHoursStr) < 2:
        timeHoursStr = "0" + timeHoursStr
    # end if

    timeMinsStr = str(timeMins)
    if len(timeMinsStr) < 2:
        timeMinsStr = "0" + timeMinsStr
    # end if

    time = timeHoursStr + timeMinsStr

    timeNum += 15

# end while
##################### state directory ######################
try:
    if not os.path.exists(state):
        os.makedirs(state, 0o777)
    else:
        print(state, "already exists.")
except:
    print("Could not create directory.")

filePath += "/" + state
os.chdir(filePath)

##################### city directory ######################
try:
    if not os.path.exists(city):
        os.makedirs(city, 0o777)
    else:
        print(city, "already exists.")
except:
    print("Could not create directory.")


filePath += "/" + city
os.chdir(filePath)

##################### store directory ######################
try:
    if not os.path.exists(store):
        os.makedirs(store, 0o777)
    else:
        print(store, "already exists.")
except:
    print("Could not create directory.")


filePath += "/" + store
os.chdir(filePath)

##################### address directory ######################
try:
    if not os.path.exists(address):
        os.makedirs(address, 0o777)
    else:
        print(address, "already exists.")
except:
    print("Could not create directory.")

filePath += "/" + address
os.chdir(filePath)
os.chmod(filePath, 0o777)

##################### storeUsername directory ######################
try:
    if not os.path.exists(storeUsername):
        os.makedirs(storeUsername, 0o777)
    else:
        print(storeUsername, "already exists.")
except:
    print("Could not create directory.")

filePath += "/" + storeUsername
os.chdir(filePath)
os.chmod(filePath, 0o777)

path = filePath
for day in days:
    path += "/" + day + ".json"
    with open(path, 'w+') as f:
            json.dump(data, f, indent=2, sort_keys=True)
    #################################
    os.chmod(path, 0o666)
    #################################
    path = filePath

# end for


path = filePath + "/shoppingCustomers.json"
'''
with open(path, 'w+') as f:
        json.dump(data, f, indent=2)
'''

#################################
shoppingData["temp"] = []
shoppingData["queue"] = []
with open(path, 'w+') as f:
    json.dump(shoppingData, f, indent=2, sort_keys=True)
# end with
os.chmod(path, 0o666)
#################################

