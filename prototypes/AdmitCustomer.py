#!/usr/bin/env python3

from distutils.util import strtobool
from datetime import *

import sys
import json

def admitCustomer(customer, visitStartBlock, trueAdmittance = True, currentTime = datetime.now().strftime("%H%M")):
    global keys, shoppingCustomers

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
        print(username, "was added to temp storage at", currentTime)
        print("Party Size:", partySize)
        print("Visit Length:", blocksToUpdate)
        print()
    # end if

    with open('shoppingCustomers.json', 'w') as f:
        json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
    # end with
# end admitCustomer

if (__name__ == "__main__"):
    global keys, shoppingCustomers

    storeSchedule = None
    with open("mockDatabase.json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    keys = sorted(list(storeSchedule.keys()))

    with open("shoppingCustomers.json") as f:
        shoppingCustomers = json.load(f)
    # end with

    print(sys.argv[1])

    admitCustomer(json.loads(sys.argv[1]), sys.argv[2], bool(strtobool(sys.argv[3])))
# end if