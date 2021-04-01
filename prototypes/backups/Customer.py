#!/mingw64/bin/Python30/python.exe


'''
ATTRIBUTES: 

    username  - unique identifier
    partySize - how many customers in the party
    startVisit - immediate vs scheduled
    visitLength - planned visit duration in 15 min blocks
    contactInfo - how to contact the customer

'''

class Customer:
    

    def __init__(self, username, partySize = 1, startVisit = '5', visitLength = 4, contactInfo = 'customer@gmail.com'):

        self.__username = username
        self.__partySize = partySize
        self.__startVisit = startVisit
        self.__visitLength = visitLength
        self.__contactInfo = contactInfo

    # end init


    def getUsername(self):
        return self.__username
    # end getUsername

    def setUsername(self, newUsername):
        self.__username =  newUsername
    # end setVisitLength

    def getVisitLength(self):
        return self.__visitLength
    # end getVisitLength

    def setVisitLength(self, newVisitLength):
        self.__visitLength =  newVisitLength
    # end setVisitLength

    def getPartySize(self):
        return self.__partySize
    # end getPartySize

    def setPartySize(self, newPartySize):
        self.__partySize = newPartySize
    # end setPartySize()



    def getStartVisit(self):
        return self.__startVisit
    # end getStartVisit

    def setStartVisit(self, newArrivalTime):
        self.__startVisit = newArrivalTime
    # end setStartVisit



    def getVisitLength(self):
        return self.__visitLength
    # end getVisitLength

    def setEndVisit(self, newLeavingTime):
        self.__endVisit = newLeavingTime
    # end setEndVisit



    def getContactInfo(self):
        return self.__contactInfo
    # end getContactInfo

    def setContactInfo(self, newContactInfo):
        self.__contactInfo = newContactInfo
    # end setContactInfo

    def __str__(self):

        output = '\n-- Customer attributes --' + '\n'
        output += 'Party Size: ' + str(self.__partySize) + '\n'
        output += 'Start Visit: ' + str(self.__startVisit) + '\n'
        output += 'Visit Length: ' + str(self.__visitLength) + '\n'
        output += 'Contact Info: ' + str(self.__contactInfo) + '\n'
        output += 'Username: ' + str(self.__username) + '\n'

        return output
        
    # end stre



# end Customer

def main():

    customer = Customer('user')
    print('partySize: ', str(customer.getPartySize()))
    print('startVisit: ', str(customer.getStartVisit()))
    print('visitLength: ', str(customer.getVisitLength()))
    print('contactInfo: ', str(customer.getContactInfo()))
    print('username: ', str(customer.getUsername()))

    customer.setPartySize(2)
    customer.setStartVisit('2')
    customer.setVisitLength(2)
    customer.setContactInfo('customer@yahoo.com')
    customer.setUsername('HRChambers')

    print('partySize: ', str(customer.getPartySize()))
    print('startVisit: ', str(customer.getStartVisit()))
    print('visitLength: ', str(customer.getVisitLength()))
    print('contactInfo: ', str(customer.getContactInfo()))
    print('username: ', str(customer.getUsername()))

    print(customer)

if __name__ == '__main__':
    main()
