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
    List<String> time = getTextController("open_time").text.split(":");
    int hour = int.parse(time[0]);
    if (openAmPm == "PM") hour += 12;

    getTextController("open_time").text =
        hour.toString().padLeft(2, '0') + time[1];

    time = getTextController("close_time").text.split(":");
    hour = int.parse(time[0]);
    if (closeAmPm == "PM") hour += 12;

    getTextController("close_time").text =
        hour.toString().padLeft(2, '0') + time[1];

    getTextController("state").text =
        getTextController("state").text.toUpperCase();
  }
}
