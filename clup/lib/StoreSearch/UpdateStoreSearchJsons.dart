import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../testing/Services.dart';
import 'dart:convert';
import '../StoreProfile/StoreProfileController.dart';

class UpdateStoreSearchJsons {

  static void update() async {
    // param: StoreProfileController storeProfile
    // store info
    // String store = storeProfile.getTextController('store_name').text;
    // String address = storeProfile.getTextController('address').text;
    // String city = storeProfile.getTextController('city').text;
    // String state = storeProfile.getTextController('state').text;

    String state = 'California';

    int stateID, cityID;

    // file info 
    String root = 'jsonManagement/';
    String txtFile;
    String jsonFile;
    String jsonLocation;
    String txtLocation;

    // flags
    bool statesUpdated = false;
    bool citiesUpdated = false;
    bool storesUpdated = false;

    // variables to hold json info
    int id;
    String idString;
    String jsonString;
    Map<String, dynamic> jsonMap;
    String key;

    // ################# STATES ##################

    // which files
    jsonFile = 'States.json';
    txtFile = 'StateID.txt';


    // locations
    jsonLocation = root + jsonFile;
    txtLocation = root + txtFile;

    // set key
    key = 'States';


    // load json into a dictionary
      jsonString = await rootBundle.loadString("$jsonLocation");
      jsonMap = jsonDecode(jsonString);

    List<dynamic> states = jsonMap[key];

    // check to see if state already exists
    if (states.contains(state) ) {

      print('State already exits');
    }

    // add the state to the list and 
    // increment the state ID
    else {
      statesUpdated = true;
      states.add(state);

      // Get new state ID
      idString = await rootBundle.loadString("$txtLocation");
      id = int.parse(idString);
      id += 1;
      idString = id.toString();

      // create full path
      String path = 'assets/jsonManagement/StateID.txt';


      var tempFile = new File(path);
      print(tempFile.path);
      tempFile.readAsString().then((String contents) {
        print(contents);
      });
      //await tempFile.writeAsString(idString);


      //jsonString = jsonEncode(jsonMap);

      //new File(txtLocation).writeAsString(id.toString());
    }

  }

}
