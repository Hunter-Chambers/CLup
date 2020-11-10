/// Flutter code sample for TextEditingController

// This example creates a [TextField] with a [TextEditingController] whose
// change listener forces the entered text to be lower case and keeps the
// cursor at the end of the input.

import 'package:flutter/material.dart';


/// This is the main application widget.
class CustomerProfileController {
  Map <String, TextEditingController> fieldsMap;

  CustomerProfileController(List<String> fields) {

    fieldsMap = new Map<String, TextEditingController>();

    for ( String field in fields) {

      fieldsMap[field] = new TextEditingController();
    }

  }

  TextEditingController getTextController(String key) {
    return fieldsMap[key]; 
  }

  /*
  
    myController.dispose();
  }
  */
}

 