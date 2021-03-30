#!/usr/bin/env python3

import json
from random import *
from datetime import *

SCAN_CHANCE = 0.50
EARLY_RELEASE_CHANCE = 0.15

SCHEDULE_CHANCE = 0.30
ASAP_CHANCE = 0.50
RANDOM_ID = 0

MAX_CAPACITY = 100
SCHEDULED_PERCENTAGE = 0.60
STORE_CLOSE = "2300"

queue = []
shoppingCustomers = {"temp": []}
keys = None

def main():
    global queue, shoppingCustomers, keys

    ###################################################################
    # initial store setup
    storeSchedule = None
    with open("mockDatabase.json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    keys = sorted(list(storeSchedule.keys()))

    for key in keys:
        shoppingCustomers[key] = {
            "scheduled": 0,
            "walk_ins": 0
        }
    # end for
    ###################################################################

    ###################################################################
    # starting to loop through the day by 15min blocks
    for key in keys:

        print("-"*60)
        print("Current Time Block:", key)
        print()

        endOfCurrentBlock = (
            datetime.strptime(key, "%H%M") +
            timedelta(minutes=15)
        ).strftime("%H%M")

        ###################################################################
        # add all scheduled customers to the temp storage
        # and update shoppingCustomers info appropriately
        for customer in storeSchedule[key]:
            if (customer != "num_reservations"):
                customerInfo = storeSchedule[key][customer]
                admitCustomer({customer: customerInfo}, key, key, False)
            # end if
        # end for
        ###################################################################

        print("ON-TIME ADMITTANCE AND EARLY RELEASES:")

        ###################################################################
        # each iteration of this for-loop acts as a single
        # minute of a 15min time block
        for i in range(15):
            currentTime = (
                datetime.strptime(key, "%H%M") +
                timedelta(minutes=i)
            ).strftime("%H%M")

            # Let's attempt 5 scans every minute
            for j in range(5):
                customer = scanChance(key)

                if (len(customer) > 0):
                    visitStartBlock = customerIsShopping(customer, key)

                    if (len(visitStartBlock) > 0):
                        releaseCustomer(customer, visitStartBlock, currentTime)
                    elif customer in shoppingCustomers["temp"]:
                        admitCustomer(customer, key, currentTime)
                    else:
                        print(customer, "QR not found")
                    # end if
                # end if

                # a chance that a customer will schedule a visit
                randomScheduling(key, currentTime)
            # end for
        # end for
        ###################################################################

        print()
        print("FAILED TO SHOW-UP ON TIME:")

        ###################################################################
        # this loop goes through the temp storage and removes anyone in there.
        # if there are customer's in here, that means they did not show up for
        # their reserved visit.
        numOfCustomers = len(shoppingCustomers["temp"]) - 1
        for customer in range(numOfCustomers, -1, -1):
            custUsername = list(shoppingCustomers["temp"][customer].keys())[0]
            releaseCustomer(shoppingCustomers["temp"][customer], "temp", endOfCurrentBlock)
        # end for
        ###################################################################

        print()
        print("ON-TIME RELEASES:")

        ###################################################################
        # for now we will assume that all customers will
        # leave by the time they are scheduled to, so we
        # need to loop through all customers that are
        # still shopping and release them if it is their time
        k = keys.index(key)
        while (k >= 0):
            usernames = list(shoppingCustomers[keys[k]].keys())

            for username in usernames:
                if (username != "scheduled" and username != "walk_ins"):
                    endVisit = (
                        datetime.strptime(keys[k], "%H%M") +
                        timedelta(minutes=(shoppingCustomers[keys[k]][username]["visit_length"] * 15))
                    ).strftime("%H%M")
                    
                    if (endVisit == endOfCurrentBlock):
                        # currentTime is updated in the for-loop above
                        releaseCustomer({username: shoppingCustomers[keys[k]][username]}, keys[k], currentTime)
                    # end if
                # end if
            # end for

            k -= 1
        # end while
        ###################################################################

        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

        print()
        print("Scheduled:", shoppingCustomers[key]["scheduled"])
        print("Walk_ins:", shoppingCustomers[key]["walk_ins"])

    # end for
    ###################################################################

# end main

def randomScheduling(currentBlock, currentTime):
    global SCHEDULE_CHANCE, RANDOM_ID
    global keys

    if (random() < SCHEDULE_CHANCE):
        username = "Random_" + str(RANDOM_ID)
        RANDOM_ID += 1

        partySize = randint(1, 5)
        visitLength = randint(1, 4)

        customer = {
            username: {
                "contact_info": "email@place.com",
                "party_size": partySize,
                "type": "walk_ins",
                "visit_length": visitLength
            }
        }

        if (random() < ASAP_CHANCE):
            startTime = "ASAP"
            valid = True
        else:
            startTime = datetime.strptime(choice(keys), "%H%M")
            nextSchedulableTimeBlock = datetime.strptime(currentBlock, "%H%M") +\
                timedelta(hours=1, minutes=15)

            if (startTime >= nextSchedulableTimeBlock):
                startTime = startTime.strftime("%H%M")

                with open("mockDatabase.json") as f:
                    storeSchedule = json.load(f)
                # end with

                f.close()

                valid = True
                i = keys.index(startTime)
                endIndex = i + visitLength
                while (valid and i < len(keys) and i < endIndex):
                    if (storeSchedule[keys[i]]["num_reservations"] + partySize > MAX_CAPACITY * SCHEDULED_PERCENTAGE):
                        valid = False
                    else:
                        i += 1
                    # end if
                # end while
            else:
                valid = False
            # end if
        # end if

        if (valid):
            makeReservation(customer, startTime, currentTime)
        # end if
    # end if
# end randomScheduling

def scanChance(currentTimeBlock):
    global SCAN_CHANCE, EARLY_RELEASE_CHANCE
    global shoppingCustomers

    if (random() < SCAN_CHANCE):
        if (random() < EARLY_RELEASE_CHANCE):
            i = keys.index(currentTimeBlock) - 3
            if (i < 0):
                i = 0
            # end if

            done = False

            while (not done and keys[i] != currentTimeBlock):
                try:
                    username, customerInfo = choice([customer for customer in shoppingCustomers[keys[i]].items() if customer[0] != "scheduled" and customer[0] != "walk_ins"])
                except IndexError:
                    username = ""
                # end try/except

                if (len(username) > 0):
                    done = True
                else:
                    i += 1
                # end if
            # end while

            if (done):
                return {username: customerInfo}
            # end if

            return {}
        elif (shoppingCustomers["temp"]):
            return choice(shoppingCustomers["temp"])
        # end if
    # end if

    return {}
# end scanChance

def makeReservation(customer, startTime, currentTime = datetime.now().strftime("%H%M")):
    global shoppingCustomers, keys

    with open("mockDatabase.json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    username, customerInfo = list(customer.items())[0]
    partySize = customerInfo["party_size"]
    visitLength = customerInfo["visit_length"]

    if (startTime == "ASAP"):
        nextTimeBlockHour = str(currentTime[:2])
        nextTimeBlockMinutes = str(((int(currentTime[2:]) // 15) * 15) + 15)
        if (nextTimeBlockMinutes == "0"):
            nextTimeBlockMinutes = "00"
            nextTimeBlockHour = str(int(nextTimeBlockHour) + 1)

            if (nextTimeBlockHour == "24"):
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
                while (not done and start < len(keys) and start < end):
                    if (storeSchedule[keys[start]]["num_reservations"] + partySize > MAX_CAPACITY * SCHEDULED_PERCENTAGE):
                        done = True
                    else:
                        start += 1
                    # end if
                # end while

                if (not done):
                    i = start
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
                shoppingScheduled = shoppingCustomers[keys[j]]["scheduled"]
                shoppingWalkins = shoppingCustomers[keys[j]]["walk_ins"]

                if (numReservations + shoppingScheduled + shoppingWalkins + partySize > MAX_CAPACITY):
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

        # get choice from customer
        # option = choice(["A", "B", "C"])
        option = "B"

        # TODO: add print statements to options
        if (option == "A"):
            storeSchedule[keys[i]].update(customer)

            for block in range(i, i + visitLength):
                storeSchedule[keys[i]]["num_reservations"] += partySize
            # end for

            with open("mockDatabase.json", "w") as f:
                json.dump(storeSchedule, f, indent=2, sort_keys=True)
            # end with

            f.close()
        elif (option == "B"):
            if (full):
                customerInfo["current_wait_time"] = 0
                queue.append(customer)
                print(username, "joined the queue of customers.")
            else:
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
                    storeSchedule[keys[i]]["num_reservations"] += partySize
                # end for

                with open("mockDatabase.json", "w") as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)
                # end with

                f.close()
            # end if
        else:
            # customer has chosen not to come to the store at all
            return
        # end if
    else:
        # a customer has scheduled a visit through the scheduling
        # interface, so we simply add it to the schedule

        storeSchedule[startTime].update(customer)

        start = keys.index(startTime)
        for i in range(start, start + visitLength):
            storeSchedule[startTime]["num_reservations"] += partySize
        # end for

        with open("mockDatabase.json", "w") as f:
            json.dump(storeSchedule, f, indent=2, sort_keys=True)
        # end with

        f.close()
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

    return done
# end checkLongWaitTime

def customerIsShopping(customer, currentTimeBlock):
    global shoppingCustomers, keys

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
        return keys[i]
    # end if

    return ""
# end customerIsShopping

def admitCustomer(customer, visitStartBlock, currentTime = datetime.now().strftime("%H%M"), trueAdmittance = True):
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

        print("*"*60)
        print("*"*60)
        print("HERE")
        print(username)
        print(customerType)
        print("*"*60)
        print("*"*60)

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

def releaseCustomer(customer, visitStartBlock, currentTime = datetime.now().strftime("%H%M")):
    global queue, shoppingCustomers, keys

    username, customerInfo = list(customer.items())[0]
    partySize = customerInfo["party_size"]
    blocksToUpdate = customerInfo["visit_length"]
    customerType = customerInfo["type"]

    if (visitStartBlock == "temp"):
        currentTimeMinutes = ((int(currentTime[2:]) // 15) - 1) * 15
        if (currentTimeMinutes == 0):
            currentTimeMinutes = "00"
        else:
            currentTimeMinutes = str(currentTimeMinutes)
        # end if

        currentTimeBlock = str(currentTime[:2]) + currentTimeMinutes

        shoppingCustomers[visitStartBlock].remove(customer)
        start = keys.index(currentTimeBlock)

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

    with open('shoppingCustomers.json', 'w') as f:
        json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
    # end with

    if (queue):
        pass

        '''
        currentTimeMinutes = int(currentTimeBlock[2:]) + 15
        if (currentTimeMinutes == 60):
            currentTimeMinutes = "00"
            currentTimeHours = str(int(currentTimeBlock[:2]) + 1)
        else:
            currentTimeMinutes = str(currentTimeMinutes)
            currentTimeHours = str(currentTimeBlock[:2])
        # end if

        if (currentTimeHours == "24"):
            nextTimeBlock = "00" + currentTimeMinutes
        else:
            nextTimeBlock = currentTimeHours + currentTimeMinutes
        # end if

        checkWaitingCustomers(currentTimeBlock)
        '''
    # end if
# end releaseCustomer

def checkWaitingCustomers(currentTimeBlock):
    pass

    # TODO: write checkWaitingCustomer logic
# end checkWaitingCustomers

if (__name__ == "__main__"):
    main()
# end if
