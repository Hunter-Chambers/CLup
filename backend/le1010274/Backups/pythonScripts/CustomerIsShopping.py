#!/usr/bin/env python3

from datetime import datetime
import sys
import json

def customerIsShopping(customer, currentTime = datetime.now().strftime("%H%M")):
    global shoppingCustomers, keys

    currentTimeBlock = str(currentTime[:2]) + str((int(currentTime[2:]) // 15) * 15)
    if (len(currentTimeBlock) < 4):
        currentTimeBlock += "0"
    # end if

    username, customerInfo = list(customer.items())[0]
    blocksToCheck = customerInfo["visit_length"]

    i = keys.index(currentTimeBlock)
    found = False
    while (not found and i >= 0 and i > i - blocksToCheck):
        if (username in shoppingCustomers[keys[i]]):
            found = True
        else:
            i -= 1
        # end if
    # end while

    if (found):
        print(keys[i])
    else:
        print("NOT SHOPPING")
    # end if
# end customerIsShopping

if (__name__ == "__main__"):
    global shoppingCustomers, keys

    state = sys.argv[1]
    city = sys.argv[2]
    store = sys.argv[3]
    address = sys.argv[4]
    storeUsername = sys.argv[5]

    filePath = "/var/www/html/cs4391/hc998658/Schedule/" + state + "/" + city + "/" +\
        store + "/" + address + "/" + storeUsername + "/"

    with open(filePath + "shoppingCustomers.json") as f:
        shoppingCustomers = json.load(f)
    # end with

    f.close()

    keys = sorted(list(shoppingCustomers.keys()))
    keys.remove("temp")
    keys.remove("queue")

    customerIsShopping(json.loads(sys.argv[6]))
# end if
