#!/usr/bin/env python3

import os
from datetime import datetime
import json

#path = "/var/www/html/cs4391/hc998658/Schedule/"
path = "/var/www/html/cs4391/le1010274/Schedule/"


for root, dNames, fNames in os.walk(path):
    if ("shoppingCustomers.json" in fNames):
        filePath = root + "/shoppingCustomers.json"

        with open(filePath) as f:
            shoppingCustomers = json.load(f)
        # end with

        f.close()

        temp = shoppingCustomers["temp"].copy()

        shoppingCustomers["temp"] = []

        with open(filePath, "w") as f:
            json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
        # end with

        f.close()

        ######################################
        # loop through temp and send emails out
        # to everyone still in it
        ######################################
    # end if
# end for
