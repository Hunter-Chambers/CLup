#!/usr/bin/env python3

from datetime import datetime
import sys
import json

def checkTempStorage(customer):
    global tempStorage

    found = False
    i = 0
    while (not found and i < len(tempStorage)):
        username = list(tempStorage[i].keys())[0]

        if (username == customer):
            found = True
        else:
            i += 1
        # end if
    # end while

    if (found):
        print("FOUND")
    else:
        print("NOT FOUND")
    # end if
# end customerIsShopping

if (__name__ == "__main__"):
    global tempStorage

    state = sys.argv[1]
    city = sys.argv[2]
    store = sys.argv[3]
    address = sys.argv[4]
    storeUsername = sys.argv[5]

    '''
    filePath = "/var/www/html/cs4391/hc998658/Schedule/" + state + "/" + city + "/" +\
        store + "/" + address + "/" + storeUsername + "/"
    '''

    filePath = "/var/www/html/cs4391/le1010274/Schedule/" + state + "/" + city + "/" +\
        store + "/" + address + "/"

    with open(filePath + "shoppingCustomers.json") as f:
        shoppingCustomers = json.load(f)
    # end with

    f.close()

    tempStorage = shoppingCustomers["temp"]

    checkTempStorage(list(json.loads(sys.argv[6]).keys())[0])
# end if
