#!/usr/bin/env python3

from Store import Store
from Customer import Customer
from ScheduleVisit import ScheduleVisit
from Queue import Queue
import json
from datetime import *

def main():
    with open("mockDatabase.json") as f:
        storeSchedule = json.load(f)
    # end with

    f.close()

    keys = sorted(list(storeSchedule.keys()))

    store = Store(100)
    store.setShoppingCustomers()

    # loop through the day by looping through each 15 min time block.
    # each loop represents going through a 15 min block of time
    for i in range(len(keys)):

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

    # end for
# end main

if (__name__ == "__main__"):
    main()
# end if
