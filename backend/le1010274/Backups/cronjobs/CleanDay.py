#!/usr/bin/env python3

import os
from datetime import datetime
import json

path = "/var/www/html/cs4391/hc998658/Schedule/"
day = datetime.now().strftime("%A").lower()
print(day)

'''
for root, dNames, fNames in os.walk(path):
    if (day + ".json" in fNames):
        filePath = root + "/" + day + ".json"

        with open(filePath) as f:
            shoppingCustomers = json.load(f)
        # end with

        f.close()

        keys = sorted(list(shoppingCustomers.keys()))

        data = {}

        for key in keys:
            data[key] = {"num_reservations": 0}
        # end for

        with open(filePath, "w") as f:
            json.dump(data, f, indent=2, sort_keys=True)
        # end with
    # end if
# end for
'''
