import 'package:flutter/material.dart';


class CustomerProfileController {
  Map <String, TextEditingController> fieldsMap;

  CustomerProfileController(List<String> fields) {

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

  }

  TextEditingController getTextController(String key) {
    return fieldsMap[key]; 
  }

  disposeTextController(String key) {
    fieldsMap[key].dispose();
  }

}

 