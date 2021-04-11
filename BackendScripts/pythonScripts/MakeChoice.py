#!/usr/bin/env python3

from datetime import datetime
from distutils.util import strtobool
import sys
import json

def makeChoice(customer):
    global filePath, keys, queue

    TODAY = datetime.now().strftime("%A").lower()

    with open(filePath + TODAY + ".json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    username, customerInfo = list(customer.items())[0]
    visitLength = customerInfo["visit_length"]
    partySize = customerInfo["party_size"]

    # get choice from customer
    option = sys.argv[7]

    # TODO: add print statements to options
    if (option == "A"):
        scheduledVisitStart = sys.argv[8]

        customer[username]["type"] = "scheduled"

        storeSchedule[keys[scheduledVisitStart]].update(customer)

        for block in range(scheduledVisitStart, scheduledVisitStart + visitLength):
            storeSchedule[keys[scheduledVisitStart]]["num_reservations"] += partySize
        # end for

        with open(filePath + TODAY + ".json", "w") as f:
            json.dump(storeSchedule, f, indent=2, sort_keys=True)
        # end with

        f.close()

        print(username, "scheduled a visit at", scheduledVisitStart)
    else:
        full = bool(strtobool(sys.argv[8]))

        if (full):
            customerInfo["current_wait_time"] = 0
            queue.append(customer)
            print(username, "joined the queue of customers.")
            print()

            with open(filePath + "shoppingCustomers.json", "w") as f:
                json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
            # end with

            f.close()
        else:
            nextTimeBlock = sys.argv[9]
            endTime = sys.argv[10]

            nextTimeBlockMinutes = str(nextTimeBlock[2:])

            endTimeMinutes = str(endTime[2:])
            visitLength = int(endTimeMinutes) - int(nextTimeBlockMinutes)

            if (visitLength == 0):
                customerInfo["visit_length"] = 4
            elif (visitLength < 0):
                customerInfo["visit_length"] = 4 - (abs(visitLength) // 15)
            else:
                customerInfo["visit_length"] = visitLength // 15
            # end if

            visitLength = customerInfo["visit_length"]

            storeSchedule[nextTimeBlock].update(customer)

            i = keys.index(nextTimeBlock)
            for block in range(i, i + visitLength):
                storeSchedule[keys[block]]["num_reservations"] += partySize
            # end for

            with open(filePath + TODAY + ".json", "w") as f:
                json.dump(storeSchedule, f, indent=2, sort_keys=True)
            # end with

            f.close()

            print(username, "scheduled a visit at", nextTimeBlock)
        # end if
    # end if
# end makeChoice

if (__name__ == "__main__"):
    global filePath, keys, queue

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

    makeChoice(json.loads(sys.argv[6]))
# end if
