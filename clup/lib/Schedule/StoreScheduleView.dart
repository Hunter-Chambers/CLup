import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';

class StoreScheduleView extends StatelessWidget {
  StoreScheduleController storeSchedule;
  StoreScheduleView({Key key, StoreScheduleController scheduleController}) 
      : this.storeSchedule = scheduleController,  super(key: key);
  List <String> timeSlots;

  Widget build(BuildContext context) {
    timeSlots = storeSchedule.timeSlots;
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Column(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            storeSchedule.getTextController('Store').text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ) ,
          ),

          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(0,4), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(4,8), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(8,12), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(12,16), scheduleController: storeSchedule,),

          Container(
            child: Divider(
            )
          ),

          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(0,4), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(4,8), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(8,12), scheduleController: storeSchedule,),
          DisplayTimeSlots(timeSlotSlice: timeSlots.sublist(12,16), scheduleController: storeSchedule,),

          Container(
            child: Divider(
            )
          ),

          Container(
            child: FloatingActionButton.extended(
              heroTag: 'SchedTimesBtn',
              onPressed: () => _onButtonPressed(),
              label: Text(
                'Schedule Times',
              ),
            )
          )
        ],
      ),
    );
  }

  _onButtonPressed() {
    /*
    Fluttertoast.showToast(
      msg: 'Hello!',
    );
    */
    storeSchedule.displaySelectedTimes();
  }

}