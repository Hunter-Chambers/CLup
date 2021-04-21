#!/usr/bin/env python3

import sys
import json
import os

# customer username
username = sys.argv[1]

# filename
fileName = username + ".json"

# customer has favorites
if( os.path.exists(fileName) ):
    with open(fileName) as f:
        data = json.load(f)
    f.close()

# customer has no favorites
else:
    data = {"favorites":[]}

# end if

stores = data["favorites"]

for i in range(0, len(stores)):
    stores[i] = stores[i].replace(",", ";")

# end for
if len(stores) == 0:
    print("no favorites")
else:
    print(stores)
# end if

