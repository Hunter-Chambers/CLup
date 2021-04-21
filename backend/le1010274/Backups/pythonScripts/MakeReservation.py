#!/usr/bin/env python3

import sys
import json
from distutils.util import strtobool
from datetime import datetime

SCHEDULED_PERCENTAGE = 0.60

def makeReservation(customer, startTime, currentTime = datetime.now().strftime("%H%M")):
    global SCHEDULED_PERCENTAGE
    global keys, shoppingCustomers, filePath, queue

    STORE_CLOSE = sys.argv[8]
    MAX_CAPACITY = int(sys.argv[9])
    TODAY = datetime.now().strftime("%A").lower()

    with open(filePath + TODAY + ".json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    username, customerInfo = list(customer.items())[0]
    partySize = customerInfo["party_size"]
    visitLength = customerInfo["visit_length"]

    if (startTime == "ASAP"):
        nextTimeBlockHour = str(currentTime[:2])
        nextTimeBlockMinutes = str(((int(currentTime[2:]) // 15) * 15) + 15)
        if (nextTimeBlockMinutes == "60"):
            nextTimeBlockMinutes = "00"
            nextTimeBlockHour = str(int(nextTimeBlockHour) + 1)

            if (len(nextTimeBlockHour) < 2):
                nextTimeBlockHour = "0" + nextTimeBlockHour
            elif (nextTimeBlockHour == "24"):
                nextTimeBlockHour = "00"
            # end if
        # end if

        nextTimeBlock = nextTimeBlockHour + nextTimeBlockMinutes

        # i needs a value just in case the program
        # does not enter the next if
        i = len(keys)

        if (nextTimeBlock in keys):
            done = False
            i = keys.index(nextTimeBlock) + 4

            while (not done and i < len(keys)):
                start = i
                end = start + visitLength
                temp = False
                while (not temp and start < len(keys) and start < end):
                    if (storeSchedule[keys[start]]["num_reservations"] + partySize > MAX_CAPACITY * SCHEDULED_PERCENTAGE):
                        temp = True
                    else:
                        start += 1
                    # end if
                # end while

                if (not temp):
                    done = True
                else:
                    i = start + 1
                # end if
            # end while
        # end if

        # TODO: give estimated wait time
        if (not (nextTimeBlock in keys) or checkLongWaitTime()):
            restOfB = "Join the queue of customers"
            full = True
        else:
            full = False
            j = keys.index(nextTimeBlock)
            end = j + 4

            while (not full and j < len(keys) and j < end):
                numReservations = storeSchedule[keys[j]]["num_reservations"]

                if (numReservations + partySize > MAX_CAPACITY):
                    full = True
                else:
                    j += 1
                # end if
            # end while

            if (full):
                restOfB = "Join the queue of customers"
            else:
                try:
                    endTime = keys[j]
                except IndexError:
                    endTime = STORE_CLOSE
                # end try/except

                restOfB = "Enter the store at " + nextTimeBlock +\
                    " and leave before " + endTime
            # end if
        # end if

        if (i < len(keys)):
            # we found a block of time that fits
            # their visit information

            print("Earliest available time at:", keys[i])
            print("Would you like to:")
            print("A) Schedule a Reservation at:", keys[i])
            print("B) " + restOfB)
        else:
            # no reservable times were found

            print("No reservable times were found that match your criteria.")
            print("Would you like to:")
            print("B) " + restOfB)
        # end if        
    else:
        # a customer has scheduled a visit through the scheduling
        # interface, so we simply add it to the schedule

        storeSchedule[startTime].update(customer)

        start = keys.index(startTime)
        for i in range(start, start + visitLength):
            storeSchedule[keys[i]]["num_reservations"] += partySize
        # end for

        with open(filePath + TODAY + ".json", "w") as f:
            json.dump(storeSchedule, f, indent=2, sort_keys=True)
        # end with

        f.close()

        print(username, "scheduled a visit at", startTime)
        print()
    # end if
# end makeReservation

def checkLongWaitTime():
    global queue

    done = False
    i = 0
    while (not done and i < len(queue)):
        currentWaitTime = (list(queue[i].values())[0])["current_wait_time"]

        if (currentWaitTime >= 30):
            done = True
        else:
            i += 1
        # end if
    # end while
# end checkLongWaitTime

if (__name__ == "__main__"):
    global keys, shoppingCustomers, filePath, queue

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

    makeReservation(json.loads(sys.argv[6]), sys.argv[7])
# end if
