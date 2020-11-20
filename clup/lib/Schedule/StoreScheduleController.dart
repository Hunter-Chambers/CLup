import 'package:flutter/material.dart';


class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;
  List <String> timeSlots;

  StoreScheduleController(List<String> fields,) {

    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                 ];

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

 