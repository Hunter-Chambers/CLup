import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Services/Services.dart';
import 'package:intl/intl.dart';




class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;

  List <String> timeSlots;
  List <String> days;
  Map <String, bool> timesAvailable;
  Map <String, String> reserved;
  Map <int, String> selectedTimes;
  int limit;

  StoreScheduleController(List<String> fields,) {
    limit = 0;
    timeSlots = [];
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
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

  setDays() {
    String today = (DateFormat.E().format(DateTime.now()));

    //today = "Wed";

    bool done = false;
    int i = 0;
    while (!done && i < days.length) {
      if( days[i].contains(today)) {
        done = true;
      }
      else {
        i++;
      }
    }

    List<String> temp = [];

    if (done) {

      days[i] = "Today - " + days[i];
      int k = i;
      for (int j = 0; j<days.length; j++) {
        temp.add(days[k]);
        k++;
        if( k > 6 ) {
          k = 0;
        }
      }
      days = temp;

    }


  }

  setSchedule() async {

    String storeInfo = getTextController("Store").text;
    List<String> storeInfoSplit = storeInfo.split(",");

    String store = storeInfoSplit[0];
    String address = storeInfoSplit[1];
    String city = storeInfoSplit[2];
    String state = storeInfoSplit[3];
    state = state.replaceAll("\n", "");
    String day = getTextController("day").text.toLowerCase();

    String temp = await Services.getSchedule(state, city, store, address, day);
    timeSlots = temp.split(",");
    timeSlots = timeSlots.sublist(0, timeSlots.length - 1);

    bool available;
    String key;
    int numReserved;

    String mins;
    String hours;
    int capacity = 0;
    print('length: '+ timeSlots.length.toString());

    for(int i =0; i<timeSlots.length; i++) {
      if (timeSlots[i].contains('capacity')) {
        print(timeSlots[i]);
        capacity = int.parse(timeSlots[i].split(':').last);
        //print('found capacity: ' + capacity.toString());
      };
    }

    int limit = (capacity * .6) as int;
    this.limit = limit;
    print(limit);

    for(int i =0; i<timeSlots.length; i++) {
      if ( !timeSlots[i].contains('capacity')){

        String time = timeSlots[i];
        key = time.split(":").first;
        hours = key.substring(0,2);
        mins = key.substring(2);
        String startTime = hours + ":" + mins;


        int minsNum = int.parse(mins);
        minsNum += 15;
        mins = minsNum.toString();
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
        if (numReserved < limit) {
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
    */

    /*
    print(timesAvailable);
    print("\n");
    print("\n");
    */

      }
      timeSlots = timeSlots.sublist(0, timeSlots.length-1);
      //print(timeSlots);
      
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

 