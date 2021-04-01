#!/c/Users/easte/AppData/Local/Programs/Python/Python38/python.exe

'''#!/mingw64/bin/Python30/python.exe'''
from Customer import *
from Queue  import * 
import json
import math
from datetime import *
import sys


'''
ATTRIBUTES: 


    dict storeSchedule - key: String time slot
                         value: int current reservations
    dict reservations  - key: String time slot
                         value: list of customer contact info
BEHAVIOURS:

    makeReservation()  - check desired time slots, 
                         if current reservations + new reservations 
                         < 60% store capacity -> make reservation

                         parms: customer (contact info, visit start, visit length)
                                schedule (dictionary timeslots x numReservations
                                          dictionary timeslots x customer contact info)
                                queue    (queue of waiting customers)
                                limit    (number of scheduled reservations allowed)


'''

def makeReservation(customer, startTime, currentTime = datetime.now().strftime("%H%M")):
    global shoppingCustomers, keys
    partySize = 3
    visitLength = 2
    customer = {
        "username": {
            "contact_info": "email@place.com",
            "party_size": partySize,
            "type": "walk_ins",
            "visit_length": visitLength
        }
    }

    print(sys.argv[1])
    # customer.setUsername()
    # customer.setPartySize()
    # customer.setStartVisit()
    # customer.setVisitLength()
    # customer.setContactInfo()


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
                #shoppingScheduled = shoppingCustomers[keys[j]]["scheduled"]
                #shoppingWalkins = shoppingCustomers[keys[j]]["walk_ins"]

                if (numReservations + partySize > MAX_CAPACITY):
                #if (numReservations + shoppingScheduled + shoppingWalkins + partySize > MAX_CAPACITY):
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
            customer[username]["type"] = "scheduled"

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
                print()
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
                    storeSchedule[keys[block]]["num_reservations"] += partySize
                # end for

                with open("mockDatabase.json", "w") as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)
                # end with

                f.close()

                print(username, "scheduled a visit at", nextTimeBlock)
                print()
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
            storeSchedule[keys[i]]["num_reservations"] += partySize
        # end for

        with open("mockDatabase.json", "w") as f:
            json.dump(storeSchedule, f, indent=2, sort_keys=True)
        # end with

        f.close()

        print(username, "scheduled a visit at", startTime)
        print()
    # end if
# end makeReservation





# end ScheduleVisit

def main():

    customer = Customer('customer')

    customer.setPartySize(2)
    customer.setStartVisit('ASAP')
    customer.setVisitLength(3)
    customer.setContactInfo('customer@yahoo.com')

    print('partySize: ', str(customer.getPartySize()))
    print('startVisit: ', str(customer.getStartVisit()))
    print('visitLength: ', str(customer.getVisitLength()))
    print('contactInfo: ', str(customer.getContactInfo()))

    print(customer)


    shoppingCustomers = {
            "0000": {'scheduled': 16, 'walk_ins': 0},
            "0015": {'scheduled': 40, 'walk_ins': 0},
            "0030": {'scheduled': 53, 'walk_ins': 0},
            "0045": {'scheduled': 59, 'walk_ins': 0},
            "0100": {'scheduled': 60, 'walk_ins': 0},
            "0115": {'scheduled': 43, 'walk_ins': 0},
            "0130": {'scheduled': 21, 'walk_ins': 0},
            "0145": {'scheduled': 0, 'walk_ins': 0}
            }
    limit = 60

    makeReservation(customer, '1200' )

    print('*'*60)
    print(shoppingCustomers)
    print('*'*60)


    customer = Customer('customer2')
    customer.setPartySize(3)
    customer.setStartVisit('0015')
    customer.setVisitLength(3)
    customer.setContactInfo('customer@hotmail.com')

    makeReservation(customer, '1200')

    print('*'*60)
    print(shoppingCustomers)
    print('*'*60)

if __name__ == '__main__':
    main()
