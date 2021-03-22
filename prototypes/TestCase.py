#!/mingw64/bin/Python30/python.exe


from Store import Store
from Customer import Customer
from ScheduleVisit import ScheduleVisit
import json
from datetime import *
from random import *


scheduleChance = 0.30
asapChance = 0.50


randomID = 0


def randomScheduling(store, startTimes, currentTime):
    global scheduleChance, asapChance, randomID

    # check if a random scheduling is occurring
    if (random() < scheduleChance):
        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

        # choose to generate 1 to 5 visits
        visitsToSchedule = randint(1, 5)

        for i in range(visitsToSchedule):
            # generate a customer with a random party size of 1 to 5,
            # and a random visit length of 15min to 1hr
            customer = Customer("Random_" + str(randomID), randint(1, 5), None, randint(1, 4), "email@place.com")
            randomID += 1

            # there is a 50% chance of the customer choosing ASAP
            if (random() < asapChance or not startTimes):
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
                ScheduleVisit.makeReservation(customer, store.getQueue(), int(store.getStoreCapacity() * 0.60), store.getShoppingCustomers(), datetime.strptime(currentTime, "%H%M"))
            # end if
        # end for
    # end if
# end randomScheduling

def main():
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

        #############################################################
        # this is a 30% chance for some customers to schedule a visit
        # in the future.
        randomScheduling(store, keys[i + 4:], keys[i])
        #############################################################

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

        with open("mockDatabase.json") as f:
            storeSchedule = json.load(f)
        # end with

        f.close()

    # end for
    #****************************************************************
# end main

if (__name__ == "__main__"):
    main()
# end if
