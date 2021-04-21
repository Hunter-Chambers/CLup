#!C:\Users\easte\AppData\Local\Programs\Python\Python38\python.exe

''' Psuedo Code '''
## read post
## get state from map
## check state.json to see if state already exists
## if not
## 		increment increment state ID, and add it
##
##
##     storesUpdated = True

## get city from map
## if state did not exist,
## 		add new state key, increment city ID
## else
## 		check city.json to see if city already exists
## if not
## 		increment city ID add city
##
##
## get store name from map
## if city did not exist
## 		add new city key with state ID
## else
## 		check store name already exists
## 		if not
## 			add it
##
##
##
## get address from map
## if store name did not exist
## 		add new store name key with city ID
## 	else
## 		add address
##
import json
import sys
import os

# store info
state = sys.argv[1]
city = sys.argv[2]
store = sys.argv[3]
address = sys.argv[4]

state = state.replace("-", " ")
city = city.replace("-", " ")
store = store.replace("-", " ")
address = address.replace("-", " ")

#print(state)
#print(city)
#print(store)
#print(address)

stateID = None
cityID = None

os.chdir(".")
print(os.curdir)

# file locations
statesJson = "./States.json"
citiesJson = "./Cities.json"
storesJson = "./Stores.json"
addressesJson = "./Addresses.json"

# flags
statesUpdated = False
citiesUpdated = False
storesUpdated = False

# variable to hold json info
data = None

# if files don't yet exist
if not os.path.exists(statesJson):

    # states
    data = {'states':[]}
    with open(statesJson, 'w') as f:
        json.dump(data, f, indent=2)

    os.chmod(statesJson, 0o666)

    # cities
    data = {}
    with open(citiesJson, 'w') as f:
        json.dump(data, f, indent=2)

    os.chmod(citiesJson, 0o666)

    # stores
    data = {}
    with open(storesJson, 'w') as f:
        json.dump(data, f, indent=2)

    os.chmod(storesJson, 0o666)

    # addresses
    data = {}
    with open(addressesJson, 'w') as f:
        json.dump(data, f, indent=2)

    os.chmod(addressesJson, 0o666)

    # state ID
    with open('StateID.txt', 'w') as f:
        f.write('0')

    # city ID
    with open('CityID.txt', 'w') as f:
        f.write('0')

# end if





################# STATES ##################

# load json into a dictionary
with open(statesJson) as f:
    data = json.load(f)


# check to see if state already exists
if state in data['states']:
    print('State already exists')

# add the state to the list and
# increment the state ID
else:
    statesUpdated = True
    data['states'].append(state)
    with open('./StateID.txt', 'r') as f:
        text = f.read()
        stateID = int(text)
        stateID += 1

    try:
        # write new stateID back to the file
        with open('./StateID.txt', 'w') as f:
            f.write(str(stateID))
    except Exception as e:
        print("Couldn't write: ", e)

    # update States.json with new list
    with open(statesJson, 'w') as f:
        json.dump(data, f, indent=2)


################# CITIES ##################

# load Cities.json as dictionary
with open(citiesJson) as f:
    data = json.load(f)

# set key
key = state

# new state was added, update keys
if statesUpdated:

    citiesUpdated = True

    # retrieve and update city ID
    with open('./CityID.txt', 'r') as f:
        text = f.read()
        cityID = int(text)
        cityID += 1

    # write new cityID back to the file
    with open('./CityID.txt', 'w') as f:
        f.write(str(cityID))

    # add new key
    data[key] = {
            'id' : stateID,
            'cities': [city]
            }


# state already existed
else:

    # check to see if city exits
    if city in data[key]['cities']:
        print("City already exists")

    # if city didn't exist, add it to the list
    # and increment cityID
    else:

        citiesUpdated = True

        # update list
        data[key]['cities'].append(city)

        # retrieve and update city ID
        with open('./CityID.txt', 'r') as f:
            text = f.read()
            cityID = int(text)
            cityID += 1

        # write new cityID back to the file
        with open('./CityID.txt', 'w') as f:
            f.write(str(cityID))

# get state ID
stateID = data[key]['id']

# update Cities.json with new info
with open(citiesJson, 'w') as f:
    json.dump(data, f, indent=2)


################# STORES ##################

# load Stores.json as dictionary
with open(storesJson) as f:
    data = json.load(f)


# assemble key
key = city + '-' + str(stateID)

# new city was added, update keys
if citiesUpdated:

    storesUpdated = True

    # add new key
    data[key] = {
            'id' : cityID,
            'stores': [store]
            }


# city already existed
else:

    # check to see if store exits
    if store in data[key]['stores']:
        print("Store already exists")

    # if store didn't exist, add it to the list
    else:

        storesUpdated = True

        # update list
        data[key]['stores'].append(store)

# get city ID
cityID = data[key]['id']

# update Stores.json with new info
with open(storesJson, 'w') as f:
    json.dump(data, f, indent=2)


################# ADDRESSES ##################


# load Addresses.json as dictionary
with open(addressesJson) as f:
    data = json.load(f)

# assemble key
key = store + '-' + str(cityID)

# new city was added, update keys
if storesUpdated:

    # add new key
    data[key] = {
            'addresses': [address]
            }


# store already existed
else:

    # check to see if address exits
    if address in data[key]['addresses']:
        print("Address already exists")

    # if address didn't exist, add it to the list
    else:

        # update list
        data[key]['addresses'].append(address)


# update Addresses.json with new info
with open(addressesJson, 'w') as f:
    json.dump(data, f, indent=2)

