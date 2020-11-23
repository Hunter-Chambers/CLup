import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;

  List <String> timeSlots;
  Map <String, bool> timesAvailable;
  Map <int, String> selectedTimes;

  StoreScheduleController(List<String> fields,) {

    timeSlots = ['8:00 - 8:15', '8:15 - 8:30', '8:30 - 8:45', '8:45 - 9:00',
                '9:00 - 9:15', '9:15 - 9:30', '9:30 - 9:45', '9:45 - 10:00',
                '10:00 - 10:15', '10:15 - 10:30', '10:30 - 10:45', '10:45 - 11:00',
                '11:00 - 11:15', '11:15 - 11:30', '11:30 - 11:45', '11:45 - 12:00',
                '1:00 - 1:15', '1:15 - 1:30', '1:30 - 1:45', '1:45 - 2:00',
                '2:00 - 2:15', '2:15 - 2:30', '2:30 - 2:45', '2:45 - 3:00',
                '3:00 - 3:15', '3:15 - 3:30', '3:30 - 3:45', '3:45 - 4:00',
                '4:00 - 4:15', '4:15 - 4:30', '4:30 - 4:45', '4:45 - 5:00',
                 ];

    timesAvailable = {'8:00 - 8:15':true, '8:15 - 8:30':false, '8:30 - 8:45':true, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':false,
                '10:00 - 10:15':true, '10:15 - 10:30':false, '10:30 - 10:45':false, '10:45 - 11:00':true,
                '11:00 - 11:15':true, '11:15 - 11:30':false, '11:30 - 11:45':true, '11:45 - 12:00':false,
                '1:00 - 1:15':false, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':false, '2:15 - 2:30':true, '2:30 - 2:45':true, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':true,
                '4:00 - 4:15':true, '4:15 - 4:30':true, '4:30 - 4:45':false, '4:45 - 5:00':true,
                 };

    selectedTimes = new Map<int, String>();

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

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

  updateSelectedTimes(int index, String time){

    // check if adding first time    
    if (selectedTimes.length == 0) {
      selectedTimes[index] = time;
    }

    // remove selected time if already exists
    else if (selectedTimes.containsKey(index)) {
      selectedTimes.remove(index);
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
        );

      }
    }

  }

  displaySelectedTimes() {
    String output = '';
    selectedTimes.forEach( (key, value) {
      output += value + ' ';
    });

   Fluttertoast.showToast(
     msg: output,
     gravity: ToastGravity.BOTTOM,
     toastLength: Toast.LENGTH_SHORT,
   );

  }

}

 