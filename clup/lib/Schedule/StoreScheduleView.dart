import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';

class StoreScheduleView extends StatelessWidget {
  StoreScheduleController storeSchedule;
  StoreScheduleView({Key key, StoreScheduleController controller}) : this.storeSchedule = controller,  super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Schedule a Visit Page")),
      body: Center(
        child: Container(
          child: Text(
            "This is the Store Schedule Page\n" + 
            storeSchedule.getTextController('Store').text
            ),
        )
      )
    );
  }

}