import json
import sys


def main():
    fileName = sys.argv[1]
    menu = sys.argv[2]
    needID = sys.argv[3]
    ID = None
    menu = menu.replace(":", " ")

    if fileName == "Cities.json":
        key = "cities"
    elif fileName == "Stores.json":
        key = "stores"
    elif fileName == "Addresses.json":
        key = "addresses"

    with open(fileName) as f:
        data = json.load(f)
    f.close()
    if fileName == "States.json":
        menuItems = data[menu]
    else:
        menuItems = data[menu][key]

    if needID == "true":
        ID = data[menu]['id']

    if ID:
        menuItems.append(str(ID))

    print(menuItems)

if __name__ == "__main__":
    main()


