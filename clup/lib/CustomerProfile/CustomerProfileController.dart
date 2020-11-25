import 'package:flutter/material.dart';

class CustomerProfileController {
  Map<String, TextEditingController> fieldsMap;
  List<String> favoriteStores;
  List<String> visits;

  CustomerProfileController(List<String> fields) {
    fieldsMap = new Map<String, TextEditingController>();

    for (String field in fields) {
      fieldsMap[field] = new TextEditingController();
    }

    favoriteStores = ['Walmart', 'Albertsons', 'Walgreens'];
    visits = [
      'visit_time;customer_username;customer_contact;store_name;address;city;state;zipcode',
    ];
  }

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
}
