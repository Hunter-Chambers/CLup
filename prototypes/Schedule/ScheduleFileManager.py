#!C:\Users\easte\AppData\Local\Programs\Python\Python38\python.exe
import json
import os
import sys


# store info
state = sys.argv[1]
city = sys.argv[2]
store = sys.argv[3]
address = sys.argv[4]
storeUsername = sys.argv[5]
startTime = sys.argv[6]
endTime = sys.argv[7]

filePath = 'C:\\Users\\easte\\OneDrive\\Documents\\CLupProjectFiles\\Code\\prototypes\\Schedule'
# filePath = '/var/www/html/cs4391/le1010274/Schedule'
os.chdir(filePath)
days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" ]

timeHours = int(startTime[0:2])
timeMins = int(startTime[2:])
time = startTime
timeNum = timeHours * 60 + timeMins
endTimeNum = int(endTime[0:2]) * 60 + int(endTime[2:])

data = {}
while timeNum < endTimeNum:

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
        os.makedirs(state)
    else:
        print(state, "already exists.")
except:
    print("Could not create directory.")

filePath += "\\" + state
os.chdir(filePath)
##################### city directory ######################
try: 
    if not os.path.exists(city):
        os.makedirs(city)
    else:
        print(city, "already exists.")
except:
    print("Could not create directory.")


filePath += "\\" + city
os.chdir(filePath)
##################### store directory ######################
try: 
    if not os.path.exists(store):
        os.makedirs(store)
    else:
        print(store, "already exists.")
except:
    print("Could not create directory.")
    

filePath += "\\" + store
os.chdir(filePath)
##################### address directory ######################
try: 
    if not os.path.exists(address):
        os.makedirs(address)
    else:
        print(address, "already exists.")
except:
    print("Could not create directory.")

filePath += "\\" + address
os.chdir(filePath)


##################### storeUsername directory ######################
try: 
    if not os.path.exists(storeUsername):
        os.makedirs(storeUsername)
    else:
        print(storeUsername, "already exists.")
except:
    print("Could not create directory.")

filePath += "\\" + storeUsername
os.chdir(filePath)

path = filePath
for day in days:
    path += "\\" + day + ".json"
    with open(path, 'w+') as f:
            json.dump(data, f, indent=2)
    path = filePath

# end for


path = filePath + "\\shoppingCustomers.json"
with open(path, 'w+') as f:
        json.dump(data, f, indent=2)

