import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Services/Services.dart';

class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;

  List <String> timeSlots;
  Map <String, bool> timesAvailable;
  Map <String, String> reserved;
  Map <int, String> selectedTimes;

  StoreScheduleController(List<String> fields,) {
    timeSlots = [];
    timesAvailable = {};
    reserved = {};

    selectedTimes = new Map<int, String>();

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

  }

  // clear schedule
  clear(){
    timeSlots = [];
    timesAvailable = {};
    selectedTimes = {};

    // dispose of all text editing controllers
    for (String key in fieldsMap.keys) {
      fieldsMap[key].clear();
      fieldsMap[key].dispose();
    }

    fieldsMap = {};
  }
  setTempSchedule() {
    List<String> tempList = ["1", "2", "3"];
    timeSlots = tempList;
  }

  /*
  bool isLoaded() {
    if (timeSlots == []) {
      return false;
    }
    return true;
  }
  */
  setSchedule() async {

    String storeInfo = getTextController("Store").text;
    List<String> storeInfoSplit = storeInfo.split(",");

    String state = storeInfoSplit[0];
    String city = storeInfoSplit[1];
    String store = storeInfoSplit[2];
    String address = storeInfoSplit[3];

    String temp = await Services.getSchedule(state, city, store, address);
    timeSlots = temp.split(",");
    timeSlots = timeSlots.sublist(0, timeSlots.length - 1);

    bool available;
    String key;
    int numReserved;

    String mins;
    String hours;

    for(int i =0; i<timeSlots.length; i++) {
      String time = timeSlots[i];
      key = time.split(":").first;
      hours = key.substring(0,2);
      mins = key.substring(2);
      String startTime = hours + ":" + mins;


      int minsNum = int.parse(mins);
      minsNum += 15;
      if (minsNum == 60) {
        int hoursNum = int.parse(hours);
        hoursNum += 1;
        hours = hoursNum.toString();

        mins = "00";

        if (hours.length < 2) {
          hours = "0" + hours;
        }

      }

      key = startTime + " - " + hours + ":" + mins;

      numReserved = int.parse(time.split(":").last);
      if (numReserved < 60) {
        available = true;
      }
      else {
        available = false;
      }

      reserved[key] = numReserved.toString();
      timeSlots[i] = key;
      timesAvailable[key] = available;

      
    }
    /*
    print("\n");
    print("\n");
    print(timeSlots);
    print("\n");
    print("\n");


    print(timesAvailable);
    print("\n");
    print("\n");
    */

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

    
    /*
    print("---------------------------------");
    print("---------------------------------");
    print(timeSlots);
    print("---------------------------------");
    print("---------------------------------");
    print(timesAvailable);
    */

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
                '5:00 - 5:15', '5:15 - 5:30', 
                 ];

    timesAvailable = {'8:00 - 8:15':false, '8:15 - 8:30':false, '8:30 - 8:45':false, '8:45 - 9:00':true,
                '9:00 - 9:15':true, '9:15 - 9:30':true, '9:30 - 9:45':true, '9:45 - 10:00':true,
                '10:00 - 10:15':true, '10:15 - 10:30':true, '10:30 - 10:45':false, '10:45 - 11:00':false,
                '11:00 - 11:15':false, '11:15 - 11:30':true, '11:30 - 11:45':false, '11:45 - 12:00':false,
                '1:00 - 1:15':false, '1:15 - 1:30':true, '1:30 - 1:45':true, '1:45 - 2:00':true,
                '2:00 - 2:15':false, '2:15 - 2:30':false, '2:30 - 2:45':true, '2:45 - 3:00':true,
                '3:00 - 3:15':true, '3:15 - 3:30':true, '3:30 - 3:45':true, '3:45 - 4:00':false,
                '4:00 - 4:15':false, '4:15 - 4:30':false, '4:30 - 4:45':true, '4:45 - 5:00':true,
                '5:00 - 5:15':true, '5:15 - 5:30':true, 
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
    if ( fieldsMap.containsKey(key) ) {
      return fieldsMap[key]; 
    }
    throw Exception("Key not found.");
  }

  bool getAvailable(String key) {
      return timesAvailable[key]; 
  }

  List<DropdownMenuItem<String>> convertMenu(List<dynamic> items){
    if ( items != null) {
      items = items.toSet().toList();
    }

    return (
         items?.map<DropdownMenuItem<String>>((dynamic value) {
           return new DropdownMenuItem<String>(
             value: value,
             child: new Text(value),
         );
       })?.toList() ?? []
     );
   }


  bool updateSelectedTimes(int index, String time, bool room){
    bool timesUpdated;
    if (room) {
      timesUpdated = true;

      // check if adding first time    
      if (selectedTimes.length == 0) {
        selectedTimes[index] = time;
      }

      // remove selected time if already exists
      else if (selectedTimes.containsKey(index)) {
        List<int> keys = selectedTimes.keys.toList();
        keys.sort();
        if (keys.first == index || keys.last == index)
          selectedTimes.remove(index);
        else {
          Fluttertoast.showToast(
            msg: 'Selected time slots must be consecutive.',
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


  }
  else{
    timesUpdated = false;
    Fluttertoast.showToast(
            msg: 'Party size exceeds remaining spots',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            webPosition: 'center',
            );
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

 