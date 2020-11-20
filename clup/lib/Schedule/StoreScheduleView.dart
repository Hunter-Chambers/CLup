import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';

class StoreScheduleView extends StatelessWidget {
  StoreScheduleController storeSchedule;
  StoreScheduleView({Key key, StoreScheduleController scheduleController}) : this.storeSchedule = scheduleController,  super(key: key);
  List <String> timeSlots;

  Widget build(BuildContext context) {
    timeSlots = storeSchedule.timeSlots;
    return Scaffold(
      appBar: AppBar(title: Text("To Previous Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(0,4)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(4,8)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(8,12)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(12,16)),
          Container(
            child: Divider(
            )
          ),

          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(0,4)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(4,8)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(8,12)),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(12,16)),
        ],
      ),
    );
  }

}