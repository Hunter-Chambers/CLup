import json
import sys


def main():
    fileName = sys.argv[1]
    state = sys.argv[2]
    city = sys.argv[3]
    store = sys.argv[4]
    address = sys.argv[5]
    storeUsername = sys.argv[6]

    state = state.replace(":", " ")
    city = city.replace(":", " ")
    store = store.replace(":", " ")
    address = address.replace(":", " ")
    # print(state)
    filePath = "/var/www/html/cs4391/le1010274/Schedule/"
    filePath += state + "/" + city + "/" + store + "/" + address + "/"
    filePath += storeUsername + "/" + fileName


    with open(filePath) as f:
        data = json.load(f)
    f.close()

    schedule = ""
    temp = data.keys()
    temp.sort()

    for key in temp:
        schedule += key
        schedule += ":"
        schedule += str(data[key]["num_reservations"])
        schedule += ","


    print(schedule)

if __name__ == "__main__":
    main()


