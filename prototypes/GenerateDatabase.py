#!/usr/bin/env python3

from random import *
from datetime import *
import json

def main():
    startString = input("Store opens at: ")
    endString = input("Store closes at: ")
    maxScheduledCap = int(int(input("Total Store Capacity: ")) * 0.6)
    numOfVisits = int(input("How many visits to generate: "))

    startTime = datetime.strptime(startString, "%H%M")
    if (endString == "0000"):
        endTime = datetime.strptime("2345", "%H%M")
    else:
        endTime = datetime.strptime(endString, "%H%M") - timedelta(minutes=15)
    # end if
    visits = {}

    i = startTime
    while (i <= endTime):
        visits[i.strftime("%H") + i.strftime("%M")] = {"num_reservations": 0}
        i += timedelta(minutes=15)
    # end while

    keys = list(visits.keys())

    scheduledVisits = 0

    for i in range(numOfVisits):
        randomStartTime = (startTime + (random() * (endTime - startTime)))
        randomStartTime -= timedelta(minutes=randomStartTime.minute % 15)

        visitGroup = randomStartTime.strftime("%H") + randomStartTime.strftime("%M")

        partySize = randint(1, 5)
        blocks = randint(1, 4)

        keyIndex = keys.index(visitGroup)
        endBlock = keyIndex + blocks

        j = keyIndex
        valid = True
        if (endBlock >= len(keys)):
            valid = False
        # end if
        while (valid and j < endBlock):
            if (visits[keys[j]]["num_reservations"] + partySize > maxScheduledCap):
                valid = False
            else:
                j += 1
            # end if
        # end while

        if (valid):
            scheduledVisits += 1

            for j in range(keyIndex, endBlock):
                visits[keys[j]]["num_reservations"] += partySize
            # end for

            username = "Customer_Username_" + str(i)
            visits.get(visitGroup)[username] = {}

            visits.get(visitGroup).get(username)["contact_info"] = "email@place.com"
            visits.get(visitGroup).get(username)["party_size"] = partySize
            visits.get(visitGroup).get(username)["type"] = "scheduled"
            visits.get(visitGroup).get(username)["visit_length"] = blocks
        else:
            pass
            '''
            print()
            print("Visit not scheduled because:")
            print("visit_start:", randomStartTime.time())
            print("visit_length:", blocks)
            '''
        # end if
    # end for

    with open("mockDatabase.json", "w") as f:
        json.dump(visits, f, indent=2)
    # end with

    print(scheduledVisits, "visits were scheduled")
# end main

if __name__ == "__main__":
    main()
# end if
