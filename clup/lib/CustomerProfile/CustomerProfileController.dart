/// Flutter code sample for TextEditingController

// This example creates a [TextField] with a [TextEditingController] whose
// change listener forces the entered text to be lower case and keeps the
// cursor at the end of the input.

import 'package:flutter/material.dart';


/// This is the main application widget.
class CustomerProfileController {
  TextEditingController myController;

  CustomerProfileController(String text) {

    myController = TextEditingController(text: text);
    
  }

  TextEditingController getController() {
    return myController;
  }

  void dispose() {
    myController.dispose();
  }
}

 