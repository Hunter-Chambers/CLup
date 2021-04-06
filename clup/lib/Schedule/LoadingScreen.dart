import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:clup/Schedule/StoreScheduleView.dart';
import 'package:clup/CustomerProfile/CustomerProfileController.dart';

class LoadingScreen extends StatefulWidget{

  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  LoadingScreen({StoreScheduleController scheduleController, CustomerProfileController customerController}):
    storeSchedule = scheduleController, customerProfile = customerController;

  @override
  _LoadingScreenState createState() => 
    _LoadingScreenState(scheduleController: storeSchedule, customerController: customerProfile);
}

class _LoadingScreenState extends State<LoadingScreen> {
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  _LoadingScreenState({StoreScheduleController scheduleController, CustomerProfileController customerController})
  : storeSchedule = scheduleController, customerProfile = customerController;

  Widget build(BuildContext context) {
    print("made it to the loading screen");
    return Container(
      child: Text("Loading...")
    );
  }
  
}