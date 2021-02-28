import 'package:flutter/material.dart';

class StoreProfileController {
  Map<String, TextEditingController> fieldsMap;

  StoreProfileController(List<String> fields) {
    fieldsMap = new Map<String, TextEditingController>();

    for (String field in fields) {
      fieldsMap[field] = new TextEditingController();
    }
  }

  TextEditingController getTextController(String key) {
    return fieldsMap[key];
  }

  disposeTextController(String key) {
    fieldsMap[key].dispose();
  }

  void reset() {
    for (TextEditingController value in fieldsMap.values) value.clear();
  }

  void formatFields(String openAmPm, String closeAmPm) {
    String time = getTextController("open_time").text;
    time += openAmPm;
    getTextController("open_time").text = time;

    time = getTextController("close_time").text;
    time += closeAmPm;
    getTextController("close_time").text = time;

    getTextController("state").text =
        getTextController("state").text.toUpperCase();
  }
}
