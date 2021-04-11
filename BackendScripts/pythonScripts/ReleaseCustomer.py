#!/usr/bin/env python3

from datetime import datetime, timedelta
import sys
import json

def releaseCustomer(customer, visitStartBlock, currentTime = datetime.now().strftime("%H%M")):
    global queue, shoppingCustomers, keys, filePath

    username, customerInfo = list(customer.items())[0]
    partySize = customerInfo["party_size"]
    blocksToUpdate = customerInfo["visit_length"]
    customerType = customerInfo["type"]

    currentTimeMinutes = (int(currentTime[2:]) // 15) * 15
    if (currentTimeMinutes == 0):
        currentTimeMinutes = "00"
    else:
        currentTimeMinutes = str(currentTimeMinutes)
    # end if

    currentTimeBlock = str(currentTime[:2]) + currentTimeMinutes

    if (visitStartBlock == "temp"):
        previousTimeBlock = (datetime.strptime(currentTimeBlock, "%H%M") -\
            timedelta(minutes=15)).strftime("%H%M")

        shoppingCustomers[visitStartBlock].remove(customer)
        start = keys.index(previousTimeBlock)

        print(username, "did not show up for their visit.")
        print("They were removed from temp storage at", currentTime)
    else:
        shoppingCustomers[visitStartBlock].pop(username)
        start = keys.index(visitStartBlock)

        print(username, "was released at", currentTime)
    # end if

    for i in range(start, start + blocksToUpdate):
        shoppingCustomers[keys[i]][customerType] -= partySize
    # end for

    with open(filePath + 'shoppingCustomers.json', 'w') as f:
        json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
    # end with

    if (queue):
        nextTimeBlock = (datetime.strptime(currentTimeBlock, "%H%M") +\
            timedelta(minutes=15)).strftime("%H%M")

        checkWaitingCustomers(nextTimeBlock, currentTime)
    # end if
# end releaseCustomer

def checkWaitingCustomers(nextTimeBlock, currentTime):
    global queue, shoppingCustomers, keys, filePath

    TODAY = datetime.now().strftime("%A").lower()

    STORE_CLOSE = sys.argv[8]
    MAX_CAPACITY = int(sys.argv[9])

    if (nextTimeBlock != STORE_CLOSE):
        position = 0
        done = False
        while (not done and position < len(queue)):
            with open(filePath + TODAY + ".json") as f:
                storeSchedule = json.load(f)
            # end with

            f.close()

            username, customerInfo = list(queue[position].items())[0]
            partySize = customerInfo["party_size"]
            blocksToCheck = customerInfo["visit_length"]
            waitTime = customerInfo["current_wait_time"]

            start = keys.index(nextTimeBlock)
            end = start + blocksToCheck
            full = False

            while (not full and start < len(keys) and start < end):
                numReservations = storeSchedule[keys[start]]['num_reservations']

                if (numReservations + partySize > MAX_CAPACITY):
                    full = True
                else:
                    start += 1
                # end if
            # end while

            if (start != end and waitTime >= 30):
                done = True
            elif (start == end and not full):
                queue.pop(position)

                with open(filePath + "shoppingCustomers.json", "w"):
                    json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
                # end with

                f.close()

                print(username, "was removed from the queue.")

                TODAY = datetime.now().strftime("%A").lower()

                storeSchedule[nextTimeBlock].update({username: customerInfo})
                visitLength = customerInfo["visit_length"]

                start = keys.index(nextTimeBlock)
                for i in range(start, start + visitLength):
                    storeSchedule[keys[i]]["num_reservations"] += partySize
                # end for

                with open(filePath + TODAY + ".json", "w") as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)
                # end with

                f.close()

                print(username, "scheduled a visit at", nextTimeBlock)
            else:
                position += 1
            # end if
        # end while
    # end if
# end checkWaitingCustomers

if (__name__ == "__main__"):
    global shoppingCustomers, keys, queue, filePath

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

    queue = shoppingCustomers["queue"]

    releaseCustomer(json.loads(sys.argv[6]), sys.argv[7])
# end if
