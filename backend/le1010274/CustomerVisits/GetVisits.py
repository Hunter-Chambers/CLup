#!/usr/bin/env python3

import sys
import json
import os

# customer username
username = sys.argv[1]

# filename
fileName = username + ".json"

# customer has visits
if( os.path.exists(fileName) ):
    with open(fileName) as f:
        data = json.load(f)
    f.close()

# customer has no visits
else:
    data = {"visits":[]}

# end if

visits = data["visits"]

for i in range(0, len(visits)):
    visits[i] = visits[i].replace(",", ";")

# end for
if len(visits) == 0:
    print("no visits")
else:
    print(visits)
# end if

