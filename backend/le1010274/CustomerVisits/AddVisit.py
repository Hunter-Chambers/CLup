#!/usr/bin/env python3

import json
import sys
import os
i = 0
for arg in sys.argv:
    print('number: ', i)
    print(arg)
    i += 1

# customer username
username = sys.argv[1]
#username = username.replace("-", " ")
# username = "customer"

# visit info
visitInfo = sys.argv[2]
#visitInfo = "Albertsons, 222 someLane, Oklahoma City, Oklahoma"
#print(visitInfo)

filePath = "/var/www/html/cs4391/le1010274/CustomerVisits/"

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
        "visits": []
    }

# end if

# add new visit info to list
if visitInfo in data["visits"]:
    print('Visit already scheduled.')
else:
    data["visits"].append(visitInfo)
    print('visit successfully added.')
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













