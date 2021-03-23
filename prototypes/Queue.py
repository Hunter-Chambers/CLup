#!/mingw64/bin/Python30/python.exe


'''

ATTRIBUTES
    List queue - list to hold the items in the queue
    Item front - next item waiting to be processed
    Item rear  - last item waiting to be processed
    int size   - keeps track of the total items in
                 the queue
    float totalWaitTime    - total wait time of recently 
                             waited customers (minutes)
    float averageWaitTime  - average wait time or recently
                             waited customers (minutes)
    int numCustomersWaited - number of recently waited
                             customers

BEHAVIORS
    add()     - adds an item to the rear of the queue
    remove()  - removes an item from the front of the queue
    peek()    - returns the item at the front of the queue
               without removing it
    size()    - returns the current size of the queue

    __str__() - overrides str() to handle Queue 
'''
class Queue:


    def __init__(self, newCapacity = 1):
        self.__queue = [] * newCapacity
        self.__size = 0
        self.__front = None
        self.__rear = None
        self.__totalWaitTime = 0
        self.__totalWaitedCustomers = 0
        self.__averageWaitTime = 0

    # end init

    def __str__(self):
        

        output = '\n'
        output += 'Size: ' +  str(self.__size) + '\n' 
        output += 'Front: ' +  str(self.__front) + '\n' 
        output += 'Rear: ' +  str(self.__rear) + '\n' 
        output += 'Queue is now: '

        if not self.__queue:
            output += '[]'

        else:

            for item in self.__queue:
                output += '['
                output += str(item)
                output += '] '
            # end for

        # end if

        output += '\n'


        return output

    # end str

    def averageWait(self, waitTime):

        if self.__size() <= 0:
            self.__totalWait = 0
            self.__numCustomersWaited = 0
            self.__averageWaitTime = 0

        else:
            self.__totalWait += waitTime
            self.__numCustomersWaited += 1
            self.__averageWaitTime = self.__totalWait / self.__numCustomersWaited
        
        # end if

    # end averageWait

    def getAverageWaitTime(self):
        return self.__averageWaitTime
    # end getAverageWaitTime

    def size(self):
        return self.__size
    # end size

    def add(self, newItem):
        
        if not self.__queue:
        # queue is empty
        # set rear and front to new item

            self.__front = 0
            self.__rear = 0

        else:
        # queue is not empty
        # increment rear

            self.__rear += 1

        # end if

        # add item and increment size
        self.__queue.append(newItem)
        self.__size += 1

    # end add

    def remove(self):

        if not self.__queue:
            nextItem = None
            print( 'Cannot remove from an empty queue')

        else:
            nextItem = self.__queue.pop(self.__front)
            self.__size -= 1
            self.__rear -= 1

            if not self.__queue:
                self.__front = None
                self.__rear = None


        return nextItem

    # end remove


    def peek(self):
        if self.__front:
            return self.__queue[self.__front]
        else:
            return None
        # end if
    # end peek
    



# end Queue

def main():

    print('Creating a new queue.')
    queue = Queue()
    print('Queue size: ', queue.size() )
    print()

    print('Add first item to the queue.')
    queue.add(1)
    print(queue)
    print()

    print('Add multiple items to the queue.')
    queue.add(4)
    queue.add(7)
    queue.add(3)
    print(queue)
    print()

    print('Take a peek at the item at the front of the queue.')
    frontItem = queue.peek()
    print('Front Item: ', frontItem)
    print(queue)

    print('Remove and item from the queue.')
    nextItem = queue.remove()
    print('Next Item: ', nextItem)
    print(queue)
    print()

    print('Remove all items from the queue.')
    for i in range( 0, queue.size() ):
        queue.remove()
    # end for

    print(queue)
    print()

    print('Attempt to remove from an empty queue.')
    queue.remove()
    print(queue)
    print()




# end main


if __name__ == '__main__':
    main()
