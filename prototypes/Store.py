#!/mingw64/bin/Python30/python.exe

import json
from Customer import *
from Queue import *
from ScheduleVisit import *
from datetime import *
#from Schedule import *

'''

ATTRIBUTES:

    int storeCapacity   - total allowable capacity
    int currentCapacity - current amount of customers
                          in the store
    float threshold     - maximum allowed immediate walk ins 
    Queue queue         - manages overflow of customers
                          waiting in line
    Schedule schedule   - manages customers with reservations
    dict shoppingCustomers  - key: customer contact info
                              value: customer party size

BEHAVIORS:

    admittingCustomer() - logic that admits a customer
                          into the store, increasing
                          current capacity
    releasingCustomer() - logic that releases a customer
                          from the store, decreasing
                          current capacity


'''

class Store:
    

    def __init__(self, storeCapacity = 1, currentCapacity = 0, threshold = .80, queue = Queue(), shoppingCustomers = {}): # , schedule = Schedule()):

        self.__storeCapacity = storeCapacity
        self.__currentCapacity = currentCapacity
        self.__threshold = threshold
        self.__queue = queue
        self.__totalWaitTime = 0
        self.__shoppingCustomers = shoppingCustomers
        #self.__schedule = schedule
        
    # end init


    def getShoppingCustomers(self):

        return self.__shoppingCustomers
        '''
        output = '' 
        for key in self.__shoppingCustomers.keys():
            output += 'Key: ' + key + '\n'
            output += 'Value: ' + self.__shoppingCustomers[key] + '\n'

        # end for
        return output
        '''
    # end getShoppingCustomers


    def setShoppingCustomers(self):
        filepath = './mockDatabase.json'

        with open(filepath) as f:
            storeSchedule = json.load(f)

        keys = list(storeSchedule.keys())
        keys.sort()
        numKeys = len(keys)

        # print()
        # print(keys)
        # print()
        # print()

        ''' Logic could be handled in the Cron Job'''
        for key in keys:
            # print(key)
            self.__shoppingCustomers[key] = {
                    'scheduled': 0,
                    'walk_ins': 0
                    }
            # print(self.__shoppingCustomers)
            # print()
            # print()

        # print(self.__shoppingCustomers)

    # end setShoppingCustomers
       

    def getQueue(self):
        return self.__queue
    # end getQueue



    def getStoreCapacity(self):
        return self.__storeCapacity
    # end getStoreCapacity

    def setStoreCapacity(self, newStoreCapacity):
        self.__storeCapacity = newStoreCapacity
    # end setStoreCapacity



    def getCurrentCapacity(self):
        return self.__currentCapacity
    # end getCurrentCapacity

    def setCurrentCapacity(self, newCurrentCapacity):
        self.__currentCapacity = newCurrentCapacity
    # end setCurrentCapacity



    def newWalkInCustomer(self, customer):
        self.__queue.add(customer)
    # end newWalkInCustomer

    '''
    def admitCustomer(self, customer, time):
        blocksToCheck = customer.getVisitLength()
        customerType = customer.getType()
        startTime = customer.getStartTime()
        keys = self.__shoppingCustomers.keys()
        keys.sort
        numKeys = len(keys)




        if ( customerType == 'Scheduled' ):
            admitScheduledCustomer(customer, startTime)
        # end if

        elif ( customerType == 'walk_ins' ):
            start = keys.index(startTime)
            room = True
            for ( i in range(start, start + blocksToCheck) ):
                numWalkIns = self.__shoppingCustomers[i]['walk_ins']
                numScheduled = self.__shoppingCustomers[i]['scheduled']

                if numWalkins + numScheduled + partySize > self.__storeCapacity:
                    room = False
                # end if

            # end for
                         
            if not room:
                print('Party Size exceeds capacity for one or more planned time slot.')
                print('Customer added to the queue.')
                queue.add(Customer)

            else:
                # add customer to shopping customers
                self.__shoppingCustomers[keys[start]][customer.getUsername()] = {
                        'contact_info' : customer.getContactInfo(),
                        'in_both' : False,
                        'party_size' : customer.getPartySize(),
                        'visit_length' : customer.getVisitLength(),
                        'visit_start' : customer.getStartVisit()
                        }


                for ( i in range(start, start + blocksToCheck) ):
                    self.__shoppingCustomers[i]['walk_ins'] += partySize

                 # end for

                with open(filepath, 'w') as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)

        # end if

        else:
        '''
        




    def admitScheduledCustomer(self, customer, time):
        # scan customer qr code and cross reference with schedule
        # if match admit customer
        # else notify did not match
        username = customer.getUsername()
        partySize = customer.getPartySize()
        blocksToCheck = customer.getVisitLength()

        keys = list(self.__shoppingCustomers.keys())
        keys.sort()
        numKeys = len(keys)

        filepath = './mockDatabase.json'

        with open(filepath) as f:
            storeSchedule = json.load(f)

        match = False
        if username in storeSchedule[time]:
            match = True



        if match:
            # admit customer
            # print('Customer admitted.')
            self.__currentCapacity += partySize
            # print('Current capacity: ', self.__currentCapacity)

            startTime = customer.getStartVisit()
            start = keys.index(startTime)
            
            self.__shoppingCustomers[startTime][username] = {
                'contact_info' : customer.getContactInfo(),
                'type' : 'scheduled',
                'party_size' : partySize,
                'visit_length' : blocksToCheck,
                'visit_start' : startTime 
           }



            for i in range(start, start + blocksToCheck):
                self.__shoppingCustomers[keys[i]]['scheduled'] += partySize


            with open('shoppingCustomers.json', 'w') as f:
                json.dump(self.__shoppingCustomers, f, indent=2, sort_keys=True)

        else:
            # notify customer
            print('QR code not found')


        # end if

    # end admitScheduledCustomer



    def checkWaitingCustomer(self):

        waitingCustomer = self.__queue.peek()

        if (waitingCustomer):
            filepath = './mockDatabase.json'

            with open(filepath) as f:
                storeSchedule = json.load(f)
            # print(waitingCustomer)
            startTime = waitingCustomer.getStartVisit()
            partySize = waitingCustomer.getPartySize()
            blocksToCheck = waitingCustomer.getVisitLength()
            if blocksToCheck > 4:
                blocksToCheck = 4
            keys = list(self.__shoppingCustomers.keys())
            keys.sort()
            numKeys = len(keys)

            start = keys.index(startTime)
            room = True
            i = start
            while i < start + blocksToCheck and i < numKeys:
                numReservations = storeSchedule[keys[i]]['num_reservations']
                numWalkIns = self.__shoppingCustomers[keys[i]]['walk_ins']
                numScheduled = self.__shoppingCustomers[keys[i]]['scheduled']

                if numWalkIns + numScheduled + numReservations + partySize > self.__storeCapacity:
                    room = False
                # end if
                
                i += 1

            # end while

            if i >= numKeys:
                room = False
                         
            if not room:
                print('Party Size exceeds capacity for one or more planned time slot.')

            else:
                # add customer to shopping customers
                customer = self.__queue.remove()
                currentHours = datetime.now().hour
                currentMinutes = datetime.now().minute + 60 * currentHours
                startWait = int(customer.getStartVisit()[2:]) + int(customer.getStartVisit()[0:2]) * 60
                customerWaitTime = currentMinutes - startWait
                print(self.__queue.averageWait(customerWaitTime))
                self.__shoppingCustomers[keys[start]][customer.getUsername()] = {
                        'contact_info' : customer.getContactInfo(),
                        'type' : 'walk_ins',
                        'party_size' : customer.getPartySize(),
                        'visit_length' : customer.getVisitLength(),
                        'visit_start' : customer.getStartVisit()
                        }


                for i in range(start, start + blocksToCheck):
                    self.__shoppingCustomers[keys[i]]['walk_ins'] += partySize

                 # end for
                '''
                with open(filepath, 'w') as f:
                    json.dump(storeSchedule, f, indent=2, sort_keys=True)
                '''

                return 1

            # end if
            return 0
        # end if


        '''
        if self.__currentCapacity + partySize < self.__threshold * self.__storeCapacity:

            # admit customer
            print('Customer admitted.')
            customer = self.__queue.remove()
            self.__currentCapacity += partySize
            print('Current capacity: ', self.__currentCapacity)
            print()
            
            # add customer to shoppingCustomers
            self.__shoppingCustomers[customer.getContactInfo()] = customer.getPartySize()
            print(self.__shoppingCustomers)

        else:
            partySize needs accounting for
            
            # otherwise calculate average wait time
            if self.__totalWaitTime <= 0:
                print('Undefined')
            else:
                print(self.__totalWaitTimes / self.__totalWaitedCustomers * self.__queue.size())

        # end if
        '''
        return 0

    # end checkWaitingCustomer




    def releaseCustomer(self, customer):


        partySize = customer.getPartySize()
        startTime = customer.getStartVisit()
        username = customer.getUsername()
        blocksToCheck = customer.getVisitLength()
        # print('startTime: ', startTime)
        keys = list(self.__shoppingCustomers.keys())
        keys.sort()

        start = keys.index(startTime)
        customerType = self.__shoppingCustomers[startTime][username]['type']
        self.__shoppingCustomers[startTime].pop(username)

        # print('Current capacity: ', self.__currentCapacity)



        for i in range(start, start + blocksToCheck):
            if self.__shoppingCustomers[keys[i]][customerType] - partySize < 0:
                self.__shoppingCustomers[keys[i]][customerType] = 0
            else:
                self.__shoppingCustomers[keys[i]][customerType] -= partySize


        with open('shoppingCustomers.json', 'w') as f:
            json.dump(self.__shoppingCustomers, f, indent=2, sort_keys=True)
            
        
        if self.__currentCapacity - partySize < 0:
            self.__currentCapacity = 0

        else:

            self.__currentCapacity -= partySize


        # end if 
            
        # print('Customer released.')
        # print('Customer party size: ', partySize)
        # print('Current capacity: ', self.__currentCapacity)
        # print()

        return self.checkWaitingCustomer()



    # end releaseCusomter

# end Store


def main():

    print('==== TESTING GETTERS/SETTERS ====')
    store = Store()
    print('storeCapacity: ', str(store.getStoreCapacity()))
    print('currentCapacity: ', str(store.getCurrentCapacity()))
    print()

    print('Set new capacities.')
    store.setStoreCapacity(100)
    store.setCurrentCapacity(95)

    print('storeCapacity: ', str(store.getStoreCapacity()))
    print('currentCapacity: ', str(store.getCurrentCapacity()))
    print()


    '''
    print('Create a customer.')
    customer = Customer('customer')
    print(customer)
    print()

    
    print('Set new attributes for the customer.')
    customer.setPartySize(2)
    customer.setStartVisit('2')
    customer.setEndVisit('3')
    customer.setContactInfo('customer@yahoo.com')

    print(customer)
    print()
    print()
    '''


    print('==== TESTING ADMIT/RELASE CUSTOMER ====')
    # initialize store
    store = None
    store = Store(100)

    '''
    print('Customer arrives.')
    customer = None
    customer = Customer('customer')
    store.newWalkInCustomer(customer)
    print(store.getQueue())
    print()
    '''

    print('Customer arrives.')
    customer2 = Customer('customer2')
    customer2.setPartySize(2)
    customer2.setStartVisit('0000')
    customer2.setVisitLength(3)
    customer2.setContactInfo('customer@yahoo.com')
    store.newWalkInCustomer(customer2)
    print(store.getQueue())
    print()

    '''
    print('Customer arrives.')
    customer3 = Customer('customer3')
    customer3.setPartySize(3)
    customer3.setStartVisit('8')
    customer3.setEndVisit('9')
    customer3.setContactInfo('customer@hotmail.com')
    store.newWalkInCustomer(customer3)
    print(store.getQueue())
    print()


    #store.admitWaitingCustomer()
    #store.admitWaitingCustomer()
    #store.admitWaitingCustomer()

    print(store.getShoppingCustomers())
    '''


    shoppingCustomers = {
            "0000": {'scheduled': 20,
                     'walk_ins': 10},
            "0015": {'scheduled': 10,
                     'walk_ins': 10},
            "0030": {'scheduled': 10,
                     'walk_ins': 10},
            "0045": {'scheduled': 10,
                     'walk_ins': 10},
            "0100": {'scheduled': 20,
                     'walk_ins': 10},
            "0115": {'scheduled': 10,
                     'walk_ins': 10},
            "0130": {'scheduled': 10,
                     'walk_ins': 10},
            "0145": {'scheduled': 10,
                     'walk_ins': 10}
            }

    store.setShoppingCustomers()


    schedCustomer = Customer("Customer_Username_2", 2, '0000', 3, 'email@place.com') 
    store.admitScheduledCustomer(schedCustomer, '0000')


    temp = store.getShoppingCustomers()

    # print(temp)

    store.releaseCustomer(schedCustomer)

# end main


if __name__ == '__main__':
    main()
