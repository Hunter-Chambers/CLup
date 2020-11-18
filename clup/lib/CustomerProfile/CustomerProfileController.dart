import 'package:flutter/material.dart';


class CustomerProfileController {
  Map <String, TextEditingController> fieldsMap;
  List <String> favoriteStores;

  CustomerProfileController(List<String> fields) {

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

    favoriteStores = ['Walmart', 'Albertsons', 'Walgreens'];

  }

  TextEditingController getTextController(String key) {
    return fieldsMap[key]; 
  }

  addFavoriteStore(String store){
    favoriteStores.add(store);
  }
  
  disposeTextController(String key) {
    fieldsMap[key].dispose();
  }

}

 