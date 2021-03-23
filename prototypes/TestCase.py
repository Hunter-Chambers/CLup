#!/usr/bin/env python3


from Store import Store
from Customer import Customer
from ScheduleVisit import ScheduleVisit
import json
from datetime import *
from random import *


scheduleChance = 0.30
asapChance = 0.50


randomID = 0
totalAsap = 0
admittedAsap = 0


def randomScheduling(store, startTimes, currentTime, customerChoice = None):
    global scheduleChance, asapChance, randomID, totalAsap, admittedAsap

    # check if a random scheduling is occurring
    if (random() < scheduleChance):
        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

        # choose to generate 10 to 40 visits
        visitsToSchedule = randint(10, 40)

        for i in range(visitsToSchedule):
            # generate a customer with a random party size of 1 to 5,
            # and a random visit length of 15min to 1hr
            customer = Customer("Random_" + str(randomID), randint(1, 5), None, randint(1, 4), "email@place.com")
            print()
            print()
            print(customer.getUsername(), "is scheduling a visit.")
            print("Party Size is:", customer.getPartySize())
            currentCapacity = store.getShoppingCustomers()[currentTime]['scheduled'] + store.getShoppingCustomers()[currentTime]['walk_ins']
            print('Current Capacity:', currentCapacity)
            print('Queue Size:', store.getQueue().size())
            randomID += 1

            # there is a 50% chance of the customer choosing ASAP
            if (random() < asapChance or not startTimes):
                totalAsap += 1
                customer.setStartVisit("ASAP")
                valid = True

            # this means the customer did not choose ASAP,
            # so we need to make sure that they can actually
            # schedule their visit at the time they chose
            else:
                # this selects a random time for the customer
                # to start their visit at
                customer.setStartVisit(choice(startTimes))

                keyIndex = startTimes.index(customer.getStartVisit())
                endBlock = keyIndex + customer.getVisitLength()

                j = keyIndex
                valid = True

                if (endBlock >= len(startTimes)):
                    valid = False
                # end if

                while (valid and j < endBlock):
                    if (storeSchedule[startTimes[j]]["num_reservations"] + customer.getPartySize() > int(store.getStoreCapacity() * 0.60)):
                        valid = False
                    else:
                        j += 1
                    # end if
                # end while
            # end if

            if (valid):
                admittedAsap += ScheduleVisit.makeReservation(customer, store.getQueue(), int(store.getStoreCapacity() * 0.60), store.getStoreCapacity(), store.getShoppingCustomers(), customerChoice, datetime.strptime(currentTime, "%H%M"))
            # end if
        # end for
    # end if
# end randomScheduling

def main():
    global totalAsap, admittedAsap
    with open("mockDatabase.json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    keys = sorted(list(storeSchedule.keys()))

    store = Store(100)
    store.setShoppingCustomers()

    #****************************************************************
    # loop through the day by looping through each 15 min time block.
    # each loop represents going through a 15 min block of time
    for i in range(len(keys)):

        print("-"*60)
        print("Current Time:", keys[i])
        print()


        print()

        ###############################################################
        # this loop simulate customers leaving at their scheduled times
        j = i - 1
        shoppingCustomers = store.getShoppingCustomers()
        while (j >= 0):
            usernames = list(shoppingCustomers[keys[j]].keys())

            for username in usernames:
                if (username != "scheduled" and username != "walk_ins"):
                    endVisit = (
                            datetime.strptime(keys[j], "%H%M") +
                            timedelta(minutes=(shoppingCustomers[keys[j]][username]["visit_length"] * 15))
                            ).strftime("%H%M")

                    if (endVisit == keys[i]):
                        partySize = shoppingCustomers[keys[j]][username]["party_size"]
                        startVisit = keys[j]
                        visitLength = shoppingCustomers[keys[j]][username]["visit_length"]
                        contactInfo = shoppingCustomers[keys[j]][username]["contact_info"]

                        customer = Customer(username, partySize, startVisit, visitLength, contactInfo)
                        admittedAsap += store.releaseCustomer(customer)

                        print(customer.getUsername(), "was released at", keys[i])
                    # end if
                # end if
            # end for


            j -= 1
        # end while
        ###############################################################

        print()

        #################################################################
        # this loop simulates customers entering at their scheduled times
        for username in storeSchedule[keys[i]]:
            if (username != "num_reservations"):
                partySize = storeSchedule[keys[i]][username]["party_size"]
                startVisit = keys[i]
                visitLength = storeSchedule[keys[i]][username]["visit_length"]
                contactInfo = storeSchedule[keys[i]][username]["contact_info"]

                customer = Customer(username, partySize, startVisit, visitLength, contactInfo)
                store.admitScheduledCustomer(customer, keys[i])

                print(customer.getUsername(), "was admitted at", keys[i])
            # end if
        # end for
        #################################################################


        print()

        #############################################################
        # this is a 30% chance for some customers to schedule a visit
        # in the future.
        randomScheduling(store, keys[i + 4:], keys[i], "B")
        #############################################################

        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

        # input()
    # end for
    print("Total ASAP Customers:", totalAsap)
    print("Admitted ASAP Customers:", admittedAsap)
    print(store.getQueue())
    #****************************************************************
    #****************************************************************
    #****************************************************************
    #****************************************************************
    #****************************************************************
    '''
    print("\n"*5)

    storeSchedule = {
            "0000" : {
                "num_reservations" : 60,
                "Test2_scheduled_1" : {
                    "contact_info" : "email@place.com",
                    "party_size" : 60,
                    "type" : "scheduled",
                    "visit_length" : 8
                    }
                },
            "0015" : {
                "num_reservations" : 60,
                },
            "0030" : {
                "num_reservations" : 60,
                },
            "0045" : {
                "num_reservations" : 60,
                },
            "0100" : {
                "num_reservations" : 60,
                },
            "0115" : {
                "num_reservations" : 60,
                },
            "0130" : {
                "num_reservations" : 60,
                },
            "0145" : {
                "num_reservations" : 60,
                }
            }

    with open("mockDatabase.json", "w") as f:
        json.dump(storeSchedule, f, indent=2)
    # end with

    keys = sorted(list(storeSchedule.keys()))

    store = Store(100)
    store.setShoppingCustomers()

    global randomID

    #****************************************************************
    # loop through the day by looping through each 15 min time block.
    # each loop represents going through a 15 min block of time
    for i in range(len(keys)):

        print("-"*60)
        print("Current Time:", keys[i])
        print()

        ###############################################################
        # this loop simulate customers leaving at their scheduled times
        j = i - 1
        shoppingCustomers = store.getShoppingCustomers()
        while (j >= 0):
            usernames = list(shoppingCustomers[keys[j]].keys())

            for username in usernames:
                if (username != "scheduled" and username != "walk_ins"):
                    endVisit = (
                            datetime.strptime(keys[j], "%H%M") +
                            timedelta(minutes=(shoppingCustomers[keys[j]][username]["visit_length"] * 15))
                            ).strftime("%H%M")

                    if (endVisit == keys[i]):
                        partySize = shoppingCustomers[keys[j]][username]["party_size"]
                        startVisit = keys[j]
                        visitLength = shoppingCustomers[keys[j]][username]["visit_length"]
                        contactInfo = shoppingCustomers[keys[j]][username]["contact_info"]

                        customer = Customer(username, partySize, startVisit, visitLength, contactInfo)
                        store.releaseCustomer(customer)

                        print(customer.getUsername(), "was released at", keys[i])
                    # end if
                # end if
            # end for

            j -= 1
        # end while
        ###############################################################

        print()

        #################################################################
        # this loop simulates customers entering at their scheduled times
        for username in storeSchedule[keys[i]]:
            if (username != "num_reservations"):
                partySize = storeSchedule[keys[i]][username]["party_size"]
                startVisit = keys[i]
                visitLength = storeSchedule[keys[i]][username]["visit_length"]
                contactInfo = storeSchedule[keys[i]][username]["contact_info"]

                customer = Customer(username, partySize, startVisit, visitLength, contactInfo)
                store.admitScheduledCustomer(customer, keys[i])

                print(customer.getUsername(), "was admitted at", keys[i])
            # end if
        # end for
        #################################################################

        print()

        #############################################################
        # Several customers want ASAP visits. We'll put some in the
        # queue to test the queue functionality.
        customer = Customer("Test2_asap_" + str(randomID), 40, "ASAP", 2, "email@place.com")
        randomID += 1

        for k in range(2, 10):
            print()
            print(customer.getUsername(), "is scheduling a visit.")
            print("Party Size is:", customer.getPartySize())

            ScheduleVisit.makeReservation(customer, store.getQueue(), int(store.getStoreCapacity() * 0.60), store.getStoreCapacity(), store.getShoppingCustomers(), "B", datetime.strptime(keys[i], "%H%M"))
            customer = Customer("Test2_asap_" + str(randomID), randint(1, 5), "ASAP", randint(1, 4), "email@place.com")
            randomID += 1
        # end for
        #input()
        #print(store.getQueue())
        #############################################################

        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

    # end for
    #****************************************************************
    '''
# end main

if (__name__ == "__main__"):
    main()
# end if
