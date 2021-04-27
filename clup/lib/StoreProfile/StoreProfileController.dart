import 'dart:math';

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
    if (openAmPm == "PM" && hour < 12) hour += 12;

    int minute = int.parse(time[1]);
    if (minute % 15 != 0) minute = minute ~/ 15 * 15 + 15;

    getTextController("open_time").text =
        hour.toString().padLeft(2, '0') + minute.toString().padLeft(2, '0');

    time = getTextController("close_time").text.split(":");
    hour = int.parse(time[0]);
    if (closeAmPm == "PM" && hour < 12) hour += 12;

    minute = int.parse(time[1]);
    if (minute % 15 != 0) minute = minute ~/ 15 * 15 + 15;

    if (minute == 60) {
      minute = 0;
      hour += 1;

      if (hour == 24) hour = 0;
    }

    getTextController("close_time").text =
        hour.toString().padLeft(2, '0') + minute.toString().padLeft(2, '0');

    getTextController("state").text =
        getTextController("state").text.toUpperCase();
  }

  void insertColons() {
    getTextController("open_time").text =
        getTextController("open_time").text.substring(0, 2) +
            ":" +
            getTextController("open_time").text.substring(2);

    getTextController("close_time").text =
        getTextController("close_time").text.substring(0, 2) +
            ":" +
            getTextController("close_time").text.substring(2);
  }
}
