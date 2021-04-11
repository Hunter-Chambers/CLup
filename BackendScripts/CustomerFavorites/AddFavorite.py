#!/usr/bin/env python3

import json
import sys
import os

# customer username
username = sys.argv[1]
#username = username.replace("-", " ")
# username = "customer"

# store info
storeInfo = sys.argv[2]
#storeInfo = storeInfo.replace("-", " ")
#storeInfo = "Albertsons, 222 someLane, Oklahoma City, Oklahoma"
#print(storeInfo)

filePath = "/var/www/html/cs4391/le1010274/CustomerFavorites/"

os.chdir(filePath)

# file name
fileName = username + ".json"
filePath += fileName

# if already exists then load
if( os.path.exists(filePath) ):

    with open(filePath) as f:
        data = json.load(f)
    f.close()

# else create new one
else:
    data = {
        "favorites": []
    }

# end if

# add new store info to list
if storeInfo in data["favorites"]:
    print('Store already in favorites.')
else:
    data["favorites"].append(storeInfo)
    print('Store successfully added')
# end if


# write back to file creating new one if
# it didn't already exist
try:
    with open(filePath, "w+") as f:
        json.dump(data, f, indent=2)
    f.close()
except Exception as e:
    print("Something happened: ", e)


os.chmod(fileName, 0o666)













