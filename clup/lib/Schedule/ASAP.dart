
import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/cupertino.dart';
import "package:clup/Services/Services.dart";
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ASAP extends StatefulWidget {

  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final String temp;

  ASAP({StoreScheduleController scheduleController,
        CustomerProfileController customerController, 
        String temp}) :
        storeSchedule = scheduleController,
        customerProfile = customerController,
        temp = temp;

  @override
  _ASAPState createState() =>
    _ASAPState( scheduleController: storeSchedule, customerController: customerProfile, temp: temp);

} 

class _ASAPState extends State<ASAP> {

  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final String temp;

  String data = "Temp val";
  List<String> items = ["1", "2"];
  List<String> schedule;
  String _value;

  _ASAPState({StoreScheduleController scheduleController,
              CustomerProfileController customerController,
              String temp}):
              storeSchedule = scheduleController,
              customerProfile = customerController,
              temp = temp;

  @override
  void initState() {
    super.initState();
      _loadSchedule().then((schedule) {
        setState(() {
          this.schedule = schedule;
        });
      });
      /*
        _loadData().then((data) {
          setState(() {
            this.data = data;
          });
        });
        */
        //_loadData();
  }

  Widget build(BuildContext context) {
    
    if ( this.schedule == null ) return LoadingScreen();
    print(this.schedule);

    //if (storeSchedule.timeSlots.length > 0 ) {
      print("Entered if.");
      _loadData().then((data) {
        setState(() {
          this.data = data;
        });
      });
    //}
    if ( this.data == null) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(title: Text("Something for now"),),
      body: Row(
        children: [
          //Text( _displayInfo().toString()),
          Text( this.data ),
          DropdownButton(
            hint: Text("Select option"),
            value: _value,
            onChanged: (value) => setState(() {
              _value = value;
            }),
            items: storeSchedule.convertMenu(items)),
          FloatingActionButton(onPressed: () => print('hi!') ),
        ],
      ),
      );
  }

Future<String> _displayInfo() {

  if (storeSchedule.timeSlots.length > 0) {

  }

}

Future _loadSchedule() async {
    String storeInfo = storeSchedule.getTextController('Store').text;
    List<String> storeInfoSplit = storeInfo.split(', ');
    String store = storeInfoSplit.first.split(',')[0];
    String address = storeInfoSplit.first.split(',')[1];
    String city = storeInfoSplit.first.split(',')[2];
    String state = storeInfoSplit.first.split(',')[3].replaceAll("\n", '');
    String day = storeSchedule.getTextController('day').text.toLowerCase();

    return this.schedule = storeSchedule.timeSlots;
}

Future _loadData() async{


    String storeInfo = storeSchedule.getTextController('Store').text;
    List<String> storeInfoSplit = storeInfo.split(', ');
    String store = storeInfoSplit.first.split(',')[0];
    String address = storeInfoSplit.first.split(',')[1];
    String city = storeInfoSplit.first.split(',')[2];
    String state = storeInfoSplit.first.split(',')[3].replaceAll("\n", '');
    String day = storeSchedule.getTextController('day').text.toLowerCase();
    await Services.getSchedule(state, city, store, address, day);
    //String visitStartTime = 'ASAP';
    //String visitEndTime = selectedTimes.split(' - ').last;
    String visitStartBlock = 'ASAP';
    //String visitEndBlock = visitEndTime.replaceAll(":", "");
    print(storeSchedule.timeSlots.length);
    String storeCloseTime = 
      storeSchedule.timeSlots[storeSchedule.timeSlots.length-1].split(' - ').last.replaceAll(":", "");
    //String maxcapacity = storeProfile.getTextController("max_capacity");
    String maxCapacity = '100';
    String username = customerProfile.getTextController("username").text;
    String contact = customerProfile.getTextController("email").text;
    String partySize = customerProfile.getTextController("party_size").text;
    String visitLength = storeSchedule.selectedTimes.keys.length.toString();
    String type = 'scheduled';

    String customer = json.encode({
      username: {
        'contact_info': contact,
        'party_size': int.parse(partySize),
        'type':type, 
        'visit_length': int.parse(visitLength)
      }
    }).replaceAll("\"", "\\\"");
    print(state);
    print(city);
    print(store);
    print(address);
    print(customer);
    print(visitStartBlock);
    print(storeCloseTime);
    print(maxCapacity);

  
  Services.showLoadingIndicator(context);
  String temp = await Services.makeReservation(state, city, store, address, customer, visitStartBlock, storeCloseTime, maxCapacity, day);


  setState(() {

    this.data = temp;

  }
  );

  Services.hideLoadingIndicator(context);
  return this.data;
}

  
}



