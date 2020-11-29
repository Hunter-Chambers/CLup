import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';

class StoreScheduleView extends StatelessWidget {
  StoreScheduleController storeSchedule;
  StoreScheduleView({Key key, StoreScheduleController scheduleController}) 
      : this.storeSchedule = scheduleController,  super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Center(
        child: Container (
          color: Colors.white,
          alignment: Alignment.center,
          height: 800,
          width: 1000,
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Text(
                  storeSchedule.getTextController('Store').text,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ) ,
                )
              ),

              DisplayTimeSlots(scheduleController: storeSchedule,),

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
        )
      ),
        
    );
  }

  _onButtonPressed() {
    storeSchedule.displaySelectedTimes();
  }

}