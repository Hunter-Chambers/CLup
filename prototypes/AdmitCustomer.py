#!/usr/bin/env python3

from distutils.util import strtobool
from datetime import *

import sys
import json

def admitCustomer(customer, visitStartBlock, trueAdmittance = True, currentTime = datetime.now().strftime("%H%M")):
    global keys, shoppingCustomers, filePath

    username, customerInfo = list(customer.items())[0]

    if (trueAdmittance):
        currentTimeMinutes = (int(currentTime[2:]) // 15) * 15
        if (currentTimeMinutes == 0):
            currentTimeMinutes = "00"
        else:
            currentTimeMinutes = str(currentTimeMinutes)
        # end if

        currentTimeBlock = str(currentTime[:2]) + currentTimeMinutes

        shoppingCustomers["temp"].remove({username: customerInfo})
        shoppingCustomers[currentTimeBlock].update({username: customerInfo})

        print(list(customer.keys())[0], "was admitted at", currentTime)
    else:
        partySize = customerInfo["party_size"]
        blocksToUpdate = customerInfo["visit_length"]
        customerType = customerInfo["type"]
        start = keys.index(visitStartBlock)

        for i in range(start, start + blocksToUpdate):
            shoppingCustomers[keys[i]][customerType] += partySize
        # end for

        shoppingCustomers["temp"].append({username: customerInfo})
        print(username + " was added to temp storage at " + currentTime)
    # end if

    with open(filePath, "w") as f:
        json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
    # end with
# end admitCustomer

if (__name__ == "__main__"):
    global keys, shoppingCustomers, filePath

    state = sys.argv[1]
    city = sys.argv[2]
    store = sys.argv[3]
    address = sys.argv[4]
    storeUsername = sys.argv[5]

    filePath = "/var/www/html/cs4391/hc998658/Schedule/" + state + "/" + city + "/" +\
        store + "/" + address + "/" + storeUsername + "/shoppingCustomers.json"

    with open(filePath) as f:
        shoppingCustomers = json.load(f)
    # end with

    f.close()

    keys = sorted(list(shoppingCustomers.keys()))
    keys.remove("temp")

    admitCustomer(json.loads(sys.argv[6]), sys.argv[7], bool(strtobool(sys.argv[8])))
# end if
