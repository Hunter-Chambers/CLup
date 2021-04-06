import 'package:flutter/material.dart';

class CustomerProfileController {
  Map<String, TextEditingController> fieldsMap;
  List<String> favoriteStores;
  Map<String, List<String>> favoriteStoresAddresses;
  List<String> visits;

  CustomerProfileController(List<String> fields) {
    fieldsMap = new Map<String, TextEditingController>();

    for (String field in fields) {
      fieldsMap[field] = new TextEditingController();
    }

    favoriteStores = ['Walmart', 'Albertsons', 'Walgreens'];
    favoriteStoresAddresses = { 
      "Walmart": ["111 somePlace", "222 someOtherPlace", "333 thatOtherPlace"],
      "HEB": ["111 somePlace", "222 someOtherPlace", "333 thatOtherPlace"],
      "Albertsons":["111 somePlace", "222 someOtherPlace", "333 thatOtherPlace"],
      "Walgreens":["111 somePlace", "222 someOtherPlace", "333 thatOtherPlace"]
    };
    visits = [
      'visit_time;customer_username;customer_contact;store_name;address;city;state;zipcode',
    ];
  }

// WILL NEED UPDATING
// *************************************************************************
// *************************************************************************
  List<String> getFavoriteStoreNames() {
    // ignore: deprecated_member_use
    List<String> temp = List<String>(favoriteStores.length);
    for (int i=0; i<favoriteStores.length; i++) {
      temp[i] = favoriteStores[i].split(",").first;
    }
    return temp;

  }

  addStoreAddress(String storeName, String address) {
    if (favoriteStoresAddresses.containsKey(storeName)) {
        favoriteStoresAddresses[storeName].add(address);
    }
    else {
      favoriteStoresAddresses[storeName] = [address];
    }
  }

  List<String> getFavoriteStoreAddresses(String storeName) {
    if( storeName == null) {
      return null;
    }
    return favoriteStoresAddresses[storeName];
  }

  String getFullStoreInfo(String store, String address) {
    int i = 0;
    bool done = false;
    while ( !done && i < favoriteStores.length) {
      if ( favoriteStores[i].contains(store) && favoriteStores[i].contains(address)) {
        done = true;
      }
      else {
        i++;
      }
    }
    if (done) {
      return favoriteStores[i];
    }
    return "Something went wrong.";
  }
// *************************************************************************
// *************************************************************************

  TextEditingController getTextController(String key) {
    return fieldsMap[key];
  }

  addFavoriteStore(String store) {
    favoriteStores.add(store);
  }

  disposeTextController(String key) {
    fieldsMap[key].dispose();
  }

  addvisit(String visitInfo) {
    visits.add(visitInfo);
  }

  removeVisit(int index) {
    visits.removeAt(index);
  }

  reset() {
    for (TextEditingController value in fieldsMap.values) value.clear();
  }

  formatPhoneNumber() {
    String phoneInput = getTextController("phone").text;
    String phone = "";
    int i = 0;

    if (phoneInput[i] != "(") {
      phone += "(";
      phone += phoneInput.substring(i, i + 3);
      i += 3;
    } else {
      phone += phoneInput.substring(i, i + 4);
      i += 4;
    }

    if (phoneInput[i] != ")") {
      phone += ")";
    } else {
      phone += phoneInput[i];
      i += 1;
    }

    if (phoneInput[i] != " ") {
      phone += " ";
      if (phoneInput[i] == "-") {
        i += 1;
      }
      phone += phoneInput.substring(i, i + 3);
      i += 3;
    } else {
      phone += phoneInput.substring(i, i + 4);
      i += 4;
    }

    if (phoneInput[i] != " ") {
      phone += " ";
    } else {
      phone += phoneInput[i];
      i += 1;
    }

    if (phoneInput[i] != "-") {
      phone += "-";
    } else {
      phone += phoneInput[i];
      i += 1;
    }

    if (phoneInput[i] != " ") {
      phone += " ";
      phone += phoneInput.substring(i, i + 4);
    } else {
      phone += phoneInput.substring(i, i + 5);
    }

    getTextController("phone").text = phone;
  }
}
