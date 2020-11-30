import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;

  List <String> timeSlots;
  Map <String, bool> timesAvailable;
  Map <int, String> selectedTimes;

  StoreScheduleController(List<String> fields,) {
    timeSlots = [];
    timesAvailable = {};

    selectedTimes = new Map<int, String>();

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

  }

  // Albertons
  setAlbertsons(){
    // Albertsons
    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                '1:00 - 1:15', '1:15 - 1:30', '1:30 - 1:45', '1:45 - 2:00',
                '2:00 - 2:15', '2:15 - 2:30', '2:30 - 2:45', '2:45 - 3:00',
                '3:00 - 3:15', '3:15 - 3:30', '3:30 - 3:45', '3:45 - 4:00',
                '4:00 - 4:15', '4:15 - 4:30', '4:30 - 4:45', '4:45 - 5:00',
                '5:00 - 5:15', '5:15 - 5:30', '5:30 - 5:45', '5:45 - 6:00',
                '6:00 - 6:15', '6:15 - 6:30', '6:30 - 6:45', '6:45 - 7:00',
                 ];

    // Albertsons
    timesAvailable = {'8:00 - 8:15':true, '8:15 - 8:30':false, '8:30 - 8:45':true, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':false,
                '10:00 - 10:15':true, '10:15 - 10:30':false, '10:30 - 10:45':false, '10:45 - 11:00':true,
                '11:00 - 11:15':true, '11:15 - 11:30':false, '11:30 - 11:45':true, '11:45 - 12:00':false,
                '1:00 - 1:15':false, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':true, '2:15 - 2:30':true, '2:30 - 2:45':true, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':true,
                '4:00 - 4:15':true, '4:15 - 4:30':true, '4:30 - 4:45':false, '4:45 - 5:00':true,
                '5:00 - 5:15':true, '5:15 - 5:30':true, '5:30 - 5:45':true, '5:45 - 6:00':true,
                '6:00 - 6:15':false, '6:15 - 6:30':false, '6:30 - 6:45':true, '6:45 - 7:00':true,
                 };

  }
  // Walmart
  setWalmart(){
    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                '1:00 - 1:15', '1:15 - 1:30', '1:30 - 1:45', '1:45 - 2:00',
                '2:00 - 2:15', '2:15 - 2:30', '2:30 - 2:45', '2:45 - 3:00',
                '3:00 - 3:15', '3:15 - 3:30', '3:30 - 3:45', '3:45 - 4:00',
                '4:00 - 4:15', '4:15 - 4:30', '4:30 - 4:45', '4:45 - 5:00',
                '5:00 - 5:15', '5:15 - 5:30', '5:30 - 5:45', '5:45 - 6:00',
                 ];

    timesAvailable = {'8:00 - 8:15':false, '8:15 - 8:30':false, '8:30 - 8:45':false, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':true,
                '10:00 - 10:15':true, '10:15 - 10:30':true, '10:30 - 10:45':false, '10:45 - 11:00':false,
                '11:00 - 11:15':false, '11:15 - 11:30':true, '11:30 - 11:45':false, '11:45 - 12:00':false,
                '1:00 - 1:15':false, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':false, '2:15 - 2:30':false, '2:30 - 2:45':true, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':false,
                '4:00 - 4:15':false, '4:15 - 4:30':false, '4:30 - 4:45':true, '4:45 - 5:00':true,
                '5:00 - 5:15':true, '5:15 - 5:30':true, '5:30 - 5:45':true, '5:45 - 6:00':true,
                 };

  }

  // HEB
  setHEB(){
    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                '1:00 - 1:15', '1:15 - 1:30', '1:30 - 1:45', '1:45 - 2:00',
                '2:00 - 2:15', '2:15 - 2:30', '2:30 - 2:45', '2:45 - 3:00',
                '3:00 - 3:15', '3:15 - 3:30', '3:30 - 3:45', '3:45 - 4:00',
                 ];

    timesAvailable = {'8:00 - 8:15':true, '8:15 - 8:30':false, '8:30 - 8:45':false, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':true,
                '10:00 - 10:15':true, '10:15 - 10:30':true, '10:30 - 10:45':false, '10:45 - 11:00':false,
                '11:00 - 11:15':false, '11:15 - 11:30':false, '11:30 - 11:45':false, '11:45 - 12:00':false,
                '1:00 - 1:15':true, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':true, '2:15 - 2:30':true, '2:30 - 2:45':true, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':true,
                '4:00 - 4:15':true, '4:15 - 4:30':true, '4:30 - 4:45':true, '4:45 - 5:00':true,
                 };

  }
  // United Supermarkets

  setUnited(){
    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                '1:00 - 1:15', '1:15 - 1:30', '1:30 - 1:45', '1:45 - 2:00',
                '2:00 - 2:15', '2:15 - 2:30', '2:30 - 2:45', '2:45 - 3:00',
                '3:00 - 3:15', '3:15 - 3:30', '3:30 - 3:45', '3:45 - 4:00',
                '4:00 - 4:15', '4:15 - 4:30', '4:30 - 4:45', '4:45 - 5:00',
                '5:00 - 5:15', '5:15 - 5:30', '5:30 - 5:45', '5:45 - 6:00',
                '6:00 - 6:15', '6:15 - 6:30', '6:30 - 6:45', '6:45 - 7:00',
                '7:00 - 7:15', '7:15 - 7:30', '7:30 - 7:45', '7:45 - 8:00',
                 ];

    timesAvailable = {'8:00 - 8:15':false, '8:15 - 8:30':false, '8:30 - 8:45':true, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':false,
                '10:00 - 10:15':true, '10:15 - 10:30':false, '10:30 - 10:45':false, '10:45 - 11:00':false,
                '11:00 - 11:15':true, '11:15 - 11:30':false, '11:30 - 11:45':true, '11:45 - 12:00':true,
                '1:00 - 1:15':true, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':false, '2:15 - 2:30':false, '2:30 - 2:45':false, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':true,
                '4:00 - 4:15':false, '4:15 - 4:30':false, '4:30 - 4:45':true, '4:45 - 5:00':true,
                '5:00 - 5:15':true, '5:15 - 5:30':true, '5:30 - 5:45':false, '5:45 - 6:00':true,
                '6:00 - 6:15':false, '6:15 - 6:30':false, '6:30 - 6:45':true, '6:45 - 7:00':true,
                '7:00 - 7:15':false, '7:15 - 7:30':false, '7:30 - 7:45':true, '7:45 - 8:00':true,
                 };

  }
  TextEditingController getTextController(String key) {
    return fieldsMap[key]; 
  }

  bool getAvailable(String key) {
      return timesAvailable[key]; 
  }

  disposeTextController(String key) {
    fieldsMap[key].dispose();
  }

  bool updateSelectedTimes(int index, String time){

    bool timesUpdated = true;

    // check if adding first time    
    if (selectedTimes.length == 0) {
      selectedTimes[index] = time;
    }

    // remove selected time if already exists
    else if (selectedTimes.containsKey(index)) {
      if (selectedTimes.keys.last == index)
        selectedTimes.remove(index);
      else {

        Fluttertoast.showToast(
          msg: 'Can only remove last selected time.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          );
        timesUpdated = false;
      }
    }
    
    else {
      // check to see if newly selected time is consecutive
      // to times already selected
      if (( index > 0 && selectedTimes.containsKey(index - 1)) || 
              (index < timeSlots.length - 1 &&  selectedTimes.containsKey(index + 1))) {
      
      // time can be selected
      selectedTimes[index] = time;
      }

      // time was not consecutive
      else {
        // prompt the user to only select consecutive times
        Fluttertoast.showToast(
          msg: 'Please only select consecutive time slots.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
        );
        timesUpdated = false;

      }

    }

      return timesUpdated;
  }

  String getSelectedTimes() {
    String output = '';
      
    if (selectedTimes.keys.isNotEmpty){
      List <int> keys = selectedTimes.keys.toList();

      keys.sort();
      int first = keys.first;
      int last = keys.last;

      output = selectedTimes[first].split(" - ").first + ' - '
        + selectedTimes[last].split(" - ").last;
    }

    return output;

  }

}

 