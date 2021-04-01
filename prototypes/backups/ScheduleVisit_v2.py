#!/c/Users/easte/AppData/Local/Programs/Python/Python38/python.exe

'''#!/mingw64/bin/Python30/python.exe'''
from Customer import *
from Queue  import * 
import json
import math
from datetime import *


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

class ScheduleVisit:
    
    

    def makeReservation(customer, queue, limit, storeCapacity, shoppingCustomers, choice = None, currentTime = datetime.now()):
        currentTime += timedelta(minutes=math.ceil(currentTime.minute / 15) * 15 - currentTime.minute)

        filepath = './mockDatabase.json'

        with open(filepath) as f:
            storeSchedule = json.load(f)
        
        partySize = customer.getPartySize()
        blocksToCheck = customer.getVisitLength()

        keys = list(storeSchedule.keys())
        keys.sort()
        numKeys = len(keys)


        if customer.getStartVisit() == 'ASAP':
            # print("entered if")            
            
            customer.setStartVisit( currentTime.strftime('%H%M') ) 

            '''
            # start visit = 1800, end visit = 1900, visitLength = 100
            visitLength = customer.getEndVisit() - customer.getStartVisit()
            blocksToCheck = 0
            while visitLength - 100 >= 0:
                blocksToCheck += 4
                visitLength -= 100
            # end while

            blocksToCheck += visitLength / 15
            '''

            hourFromNow = currentTime + timedelta(hours=1)

            done = False
            try:
                i = keys.index(hourFromNow.strftime("%H%M"))
            except ValueError:
                i = None
                done = True
            # end try/except

            if hourFromNow.date() > currentTime.date():
                i = None
                done = True
            # end if

            while not done and i < numKeys:
                valid = True
                ptr = i

                while valid and ptr - i < blocksToCheck:

                    if storeSchedule[keys[ptr]]['num_reservations'] + partySize > limit:
                        valid = False
                     
                    ptr += 1

                    if valid and ptr - i >= blocksToCheck:
                        done = True


                    elif ptr >= numKeys:
                        valid = False

                    # end if

                # end while


                if valid:
                    done = True
                else:
                    i = ptr

                # end if

            # end while
            startTime = datetime.strptime(customer.getStartVisit(), '%H%M')
            startTimeMinutes = math.floor(startTime.minute / 15) * 15
            if startTimeMinutes == 0:
                startTimeMinutes = '00'
            else:
                startTimeMinutes = str(startTimeMinutes)

            startTime = startTime.strftime('%H') + startTimeMinutes
            z = keys.index(startTime)
            startIndex = z
            full = False

            while not full and z < numKeys and z < startIndex + blocksToCheck:
                if shoppingCustomers[keys[z]]['scheduled'] + shoppingCustomers[keys[z]]['walk_ins'] + partySize >= storeCapacity:
                    full = True
                else:
                    z += 1

                # end if

            # end while


            if not full:
                # State 1
                # There is available room in the store

                print('There is currently no wait to enter the store.')


            elif queue.size() <= 0:
                # State 2
                # NO available room in the store
                # and queue is empty

                done = False
                index = 0
                while not done and index < numKeys:
                    key = keys[index]
                    if shoppingCustomers[key]['scheduled'] > 0 or shoppingCustomers[key]['walk_ins'] > 0:

                        customers = list(shoppingCustomers[key].keys())
                        customers.sort()

                        numCustomers = len(customers) - 2
                        closestCustomer = customers[0]

                        shortest = int(shoppingCustomers[key][closestCustomer]['visit_length'])
                        for cust in customers[1:numCustomers]:
                            visitLength = int(shoppingCustomers[key][cust]['visit_length'])
                            if visitLength < shortest:
                                shortest = visitLength
                                closestCustomer = cust

                            # end if

                        # end for
                        done = True

                    # end if

                    index += 1

                # end while

                # get customer end time of visit
                endTimeIndex = keys.index(key) + shoppingCustomers[key][closestCustomer]['visit_length']
                endTime = keys[endTimeIndex]

                # subtract current time minutes to from end time minutes
                # to get estimated wait time
                endTimeMinutes = int(endTime[2:]) + int(endTime[0:2]) * 60
                currentWaitMinutes = currentTime.minute + currentTime.hour * 60
                waitTime = endTimeMinutes - currentWaitMinutes

                print('Number of customers currently waiting in line: ', queue.size())
                print('Estimated wait time: ', waitTime )

            else:
                # State 3
                # NO available room in the store
                # and queue is NOT empty

                print('Number of customers currently waiting in line: ', queue.size())
                print('Estimated wait time: ', queue.getAverageWaitTime() )


            if done and i and i < numKeys:
                # print(keys)
                # print('i: ', i)
                # we found a valid block
                # prompt customer nearest available visit time
                # and display queue info

                






                
                
                
                print('Earliest available time at: ', keys[i] )

                print('Would you like to: ')
                print('A) Schedule Reservation at time: ', keys[i])
                print('B) Join the waiting queue.')
                print('C) Both schedule a reservation and wait in the queue.')
                print('D) Neither.')

            else:
                # valid block not found for the day

                print('No available times today for reservation.')

                print('B) Join the waiting queue.')
                print('D) Neither.')

            # end if/else

            if not choice:
                choice = input()

            if choice == 'A':
                # add party size of planned visit to the store reservations scheduled
                for j in range(i, i + blocksToCheck):
                    storeSchedule[keys[j]]['num_reservations'] += partySize
                
                # end for

                storeSchedule[keys[i]][customer.getUsername()] = {
                        'contact_info' : customer.getContactInfo(),
                        'in_both' : False,
                        'party_size' : customer.getPartySize(),
                        'visit_length' : customer.getVisitLength(),
                        'visit_start' : customer.getStartVisit()
                        }

                with open(filepath, 'w') as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)



            elif choice == 'B':

                k = keys.index(currentTime.strftime("%H%M"))
                '''
                room = False
                while not room and k < numKeys:
                    valid = True
                    ptr = k

                    while valid and ptr - k < blocksToCheck:

                        if shoppingCustomers[keys[ptr]]['scheduled'] + shoppingCustomers[keys[ptr]]['walk_ins'] + partySize > limit:
                            valid = False
                         
                        ptr += 1

                        if valid and ptr - k >= blocksToCheck:
                            done = True


                        elif ptr >= numKeys:
                            valid = False

                        # end if

                    # end while


                    if valid:
                        room = True
                    else:
                        k = ptr

                    # end if

                # end while
                '''

                if blocksToCheck > 4:
                    stop = 4
                else:
                    stop = blocksToCheck
                # end if

                room = True
                ptr = k
                z = 0
                while room and ptr < numKeys and z < stop:
                    # print("ptr:", ptr)
                    # print("scheduled:", shoppingCustomers[keys[ptr]]['scheduled'])
                    # print("walk_ins:", shoppingCustomers[keys[ptr]]['walk_ins'])
                    # print("limit:", limit)

                    if shoppingCustomers[keys[ptr]]['scheduled'] + shoppingCustomers[keys[ptr]]['walk_ins'] + partySize > storeCapacity:
                        
                        room = False

                    else:
                        ptr += 1

                    z += 1
                # end while




                if room:
                    # print("stop:", stop)

                    if k + stop > numKeys:
                        blocksToCheck = numKeys - k
                    # end if

                    # add to shopping customers
                    # prompt( 15 minutes to arrive | lose spot )
                    for j in range(k, k + blocksToCheck):
                        shoppingCustomers[keys[j]]['walk_ins'] += partySize
                    # end for

                    shoppingCustomers[keys[k]][customer.getUsername()] = {
                            'contact_info' : customer.getContactInfo(),
                            'party_size' : customer.getPartySize(),
                            'type' : 'walk_ins',
                            'visit_length' : blocksToCheck,
                            }

                    with open('shoppingCustomers.json', 'w') as f:
                        json.dump(shoppingCustomers, f, indent=2, sort_keys=True)
                    # end with

                    storeSchedule[keys[k]][customer.getUsername()] = {
                            'contact_info' : customer.getContactInfo(),
                            'party_size' : customer.getPartySize(),
                            'type' : 'walk_in',
                            'visit_length' : customer.getVisitLength(),
                            # 'visit_start' : customer.getStartVisit()
                            }

                    print("You have 15 minutes to scan in or you will lose your spot.")
                    return 1



                else:
                    # customer has opted to wait in line for
                    # an open spot
                    print('Joined the queue of waiting customers.')
                    customer.setStartVisit(currentTime.strftime("%H%M"))
                    queue.add(customer)
                    return 0




                
            elif choice == 'C':

                # add party size of planned visit to the store reservations scheduled
                for j in range(i, i + blocksToCheck):
                    storeSchedule[keys[j]]['num_reservations'] += partySize
                
                # end for

                storeSchedule[keys[i]][customer.getUsername()] = {
                        'contact_info' : customer.getContactInfo(),
                        'party_size' : customer.getPartySize(),
                        'type' : 'both',
                        'visit_length' : customer.getVisitLength(),
                        'visit_start' : customer.getStartVisit()
                        }

                with open(filepath, 'w') as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)




                # add customer to queue
                print('Joined the queue of waiting customers.')
                queue.add(customer)




            else:

                return


            # add to queue
            # queue.add(customer)

            # add to schedule
            # search for consecutive available slots with
            # enough room for remainder of the day

        else:
            # customer has scheduled a visit
            # through the scheduling interface
            # therefore add the visit to the schedule

            startTime = customer.getStartVisit()
            start = keys.index(startTime)

            storeSchedule[keys[start]][customer.getUsername()] = {
                    'contact_info' : customer.getContactInfo(),
                    'party_size' : customer.getPartySize(),
                    'type' : 'scheduled',
                    'visit_length' : customer.getVisitLength()
                    # 'visit_start' : customer.getStartVisit()
                    }

            for i in range(start, start + blocksToCheck):
                # print(storeSchedule[keys[i]]['num_reservations'])
                storeSchedule[keys[i]]['num_reservations'] += partySize
                # print(storeSchedule[keys[i]]['num_reservations'])


        return 0
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

    ScheduleVisit.makeReservation(customer, Queue(), limit, 100, shoppingCustomers)

    print('*'*60)
    print(shoppingCustomers)
    print('*'*60)


    customer = Customer('customer2')
    customer.setPartySize(3)
    customer.setStartVisit('0015')
    customer.setVisitLength(3)
    customer.setContactInfo('customer@hotmail.com')

    ScheduleVisit.makeReservation(customer, Queue(), limit, 100, shoppingCustomers)

    print('*'*60)
    print(shoppingCustomers)
    print('*'*60)

if __name__ == '__main__':
    main()
