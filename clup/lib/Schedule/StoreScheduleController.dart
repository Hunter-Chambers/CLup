import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Services/Services.dart';
import 'package:intl/intl.dart';




class StoreScheduleController {
  Map <String, TextEditingController> fieldsMap;

  // ***********************************************
  //      Instance Variables
  List <String> timeSlots;
  List <String> days;
  Map <String, bool> timesAvailable;
  Map <String, String> reserved;
  Map <int, String> selectedTimes;
  int limit;
  // ***********************************************


  // Constructor
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

  /* Sets the ordering of the 'Select a Day' dropdown
  /  in Schedule Visit 
  */
  setDays() {
    // Get the current day
    String today = (DateFormat.E().format(DateTime.now()));
    bool done = false;
    int i = 0;

    // Match the current day in days[]
    // Saving the index
    while (!done && i < days.length) {
      if( days[i].contains(today)) {
        done = true;
      }
      else {
        i++;
      }
    }

    // Temp array used for reording days
    List<String> temp = [];
    if (done) {

      // Mark which day is today
      days[i] = "Today - " + days[i];
      int k = i;

      // Reorder days
      for (int j = 0; j<days.length; j++) {
        temp.add(days[k]);
        k++;
        if( k > 6 ) {
          k = 0;
        }
      }

      // Reassign days[] with reordered days
      days = temp;
    }
  }



  // 
  setSchedule() async {
    // Get the current day
    String day = getTextController("day").text.toLowerCase();
    String today = (DateFormat.E().format(DateTime.now()));
    print("day: " + day);
    print("Today: " + today);
    bool isToday = false;
    int currentTimeNum;

    // Only need to do if attempting to schedule visit
    // for 'today'
    if ( day.contains(today.toLowerCase()) ) {

      isToday = true;

      DateTime currentTimeInfo = DateTime.now();
      String currentTime =  currentTimeInfo.toString().split(' ').last;

      int currentTimeHr = int.parse(currentTime.split(':')[0]);
      int currentTimeMin = int.parse(currentTime.split(':')[1]);

      currentTimeHr += 1;
      if ( currentTimeMin <= 15 ) {
        currentTimeMin = 15;
      }
      else if ( currentTimeMin <= 30 ) {
        currentTimeMin = 30;
      }
      else if ( currentTimeMin <= 45 ) {
        currentTimeMin = 45;
      }
      else {
        currentTimeMin = 0;
        currentTimeHr += 1;
      }

      String currentTimeMinString = currentTimeMin.toString();
      if ( currentTimeMinString.length < 2 ) {
        currentTimeMinString += '0';
      }
      currentTimeNum = int.parse(currentTimeHr.toString() + currentTimeMinString);

    }

    // Get store info
    String storeInfo = getTextController("Store").text;
    List<String> storeInfoSplit = storeInfo.split(",");
    String store = storeInfoSplit[0];
    String address = storeInfoSplit[1];
    String city = storeInfoSplit[2];
    String state = storeInfoSplit[3];
    state = state.replaceAll("\n", "");


    // Pull schedule info from backend
    String temp = await Services.getSchedule(state, city, store, address, day);

    // Parse start times from string into list
    timeSlots = temp.split(",");
    timeSlots = timeSlots.sublist(0, timeSlots.length - 1);

    bool available;
    String key;
    int numReserved;

    String mins;
    String hours;
    int capacity = 0;
    bool pastTime;


    // Get store capacity
    for(int i =0; i<timeSlots.length; i++) {
      if (timeSlots[i].contains('capacity')) {
        capacity = int.parse(timeSlots[i].split(':').last);
      };
    }

    // Set limit for reservations based on capacity
    int limit = (capacity * .6) as int;
    this.limit = limit;

    // For each start time, generate a time slot string
    // and a matching times available entry
    for(int i =0; i<timeSlots.length; i++) {
      if ( !timeSlots[i].contains('capacity')){
        pastTime = false;

        // Get start time
        String time = timeSlots[i];
        key = time.split(":").first;
        hours = key.substring(0,2);
        mins = key.substring(2);
        String startTime = hours + ":" + mins;


        // Derive end time from start time
        int minsNum = int.parse(mins);
        int hoursNum = int.parse(hours);

        if (isToday) {            
          String minsNumString = minsNum.toString();
          if ( minsNumString.length < 2 ) {
            minsNumString += '0';
          }
          int tempTime = int.parse(hoursNum.toString() + minsNumString);
          if ( tempTime < currentTimeNum) {
            print(tempTime);
            print(currentTimeNum);
            pastTime = true;
          }
        }

        minsNum += 15;
        mins = minsNum.toString();
        if (minsNum == 60) {
          hoursNum += 1;
          hours = hoursNum.toString();

          mins = "00";

          if (hours.length < 2) {
            hours = "0" + hours;
          }

        }

        // Reformat start time
        key = startTime + " - " + hours + ":" + mins;

        // Get number of reservations
        numReserved = int.parse(time.split(":").last);          

        // If it's past the time allowed
        // for scheduling, don't let the
        // customer schedule that time
        if (pastTime) {
          available = false;
        }
        else {
          // Determine if time slot has
          // remaining capacity
          if (numReserved < limit) {
            available = true;
          }
          else {
            available = false;
          }

        }
        // Set attributes with schedule info
        reserved[key] = numReserved.toString();
        timeSlots[i] = key;
        timesAvailable[key] = available;
      }
    }
      // NOTE: consider reworking.
      // Currently removes last key -> 'capacity:x'
      timeSlots = timeSlots.sublist(0, timeSlots.length-1);
  }

  // Returns text editing controller matching
  // specified key
  TextEditingController getTextController(String key) {
    if ( fieldsMap.containsKey(key) ) {
      return fieldsMap[key]; 
    }
    throw Exception("Key not found.");
  }

  // Returns whether or not there is any
  // remaining capacity for the
  // specified time slot
  bool getAvailable(String key) {
      return timesAvailable[key]; 
  }


  // Converts a list to a list of dropdown items
  List<DropdownMenuItem<String>> convertMenu(List<dynamic> items){

    // Removes duplicate entries
    if ( items != null) {
      items = items.toSet().toList();
    }

    // NOTE: the '?' invokes null safety
    // Returning an empty list if null
    return (
         items?.map<DropdownMenuItem<String>>((dynamic value) {
           return new DropdownMenuItem<String>(
             value: value,
             child: new Text(value),
         );
       })?.toList() ?? []
     );
   }


  // Function to provide the logic as to whether or not
  // a clicked time slot is valid to be selected
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
    // Notify user selected time slot does not
    // have enough remaining capacity to
    // accomodate customer's party size
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

  // Format and return the selected times -> 'xx:xx - yy:yy'
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

 