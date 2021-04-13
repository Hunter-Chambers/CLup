#!/usr/bin/env python3

import os
from datetime import datetime
import json


#path = "/var/www/html/cs4391/hc998658/Schedule/"
path = os.getcwd() + "/Schedule/"

currentTime = datetime.now()
day = currentTime.strftime("%A").lower()
currentTimeBlock = currentTime.strftime("%H") + str(int(currentTime.strftime("%M")) // 15 * 15).ljust(2, '0')

for root, dNames, fNames in os.walk(path):
    if ("shoppingCustomers.json" in fNames):
        filePath = root + "/shoppingCustomers.json"

        with open(filePath) as f:
            shoppingCustomers = json.load(f)
        # end with

        f.close()

        temp = shoppingCustomers["temp"].copy()

        shoppingCustomers["temp"] = []

        with open(root + "/" + day + ".json") as f:
            schedule = json.load(f)
        # end with

        f.close()

        for customer, customerInfo in schedule[currentTimeBlock].items():
            shoppingCustomers["temp"].append({customer: customerInfo})
        # end for

        shoppingCustomers["temp"].pop(0)

        with open(filePath, "w") as f:
            json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
        # end with

        f.close()

        ##############################################
        # TODO:
        # loop through temp and shoppingCustomers
        # and send emails out to everyone still in it
        ##############################################
    # end if
# end for
