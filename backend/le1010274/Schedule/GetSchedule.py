import json
import sys


def main():

    fileName = sys.argv[1]
    #fileName = 'tuesday.json'
    state = sys.argv[2]
    #state = 'Illinois'
    city = sys.argv[3]
    #city = 'Chicago'
    store = sys.argv[4]
    #store = 'United:Supermarket'
    address = sys.argv[5]
    #address = '1234:This:Way'

    state = state.replace(":", "-")
    city = city.replace(":", "-")
    store = store.replace(":", "-")
    address = address.replace(":", "-")
    #storeusername = storeusername.replace(":", "-")
    # print(state)
    filePath = "/var/www/html/cs4391/le1010274/Schedule/"
    filePath += state + "/" + city + "/" + store + "/" + address + "/"
    # filePath += storeUsername + "/" + fileName
    filePath += fileName


    with open(filePath) as f:
        data = json.load(f)
    f.close()

    schedule = ""
    temp = list(data.keys())
    temp.sort()
    for key in temp:
        if key == 'capacity':
            schedule += key
            schedule += ':'
            schedule += str(data[key])
            schedule += ','
        # end if
        else:
            schedule += key
            schedule += ":"
            schedule += str(data[key]["num_reservations"])
            schedule += ","
        #print(schedule)
    # end for


    print(schedule)

if __name__ == "__main__":
    main()


