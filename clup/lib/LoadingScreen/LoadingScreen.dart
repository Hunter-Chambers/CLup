import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget{

  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
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
    return 
    Center(child:
      Container(
        child: Text("Loading...")
      ),
    );
  }
  
}