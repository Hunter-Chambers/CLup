
import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/cupertino.dart';
import "package:clup/Services/Services.dart";
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:clup/Schedule/StoreScheduleView.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  List<String> items = ["A", "B"];
  List<String> schedule;
  String _value;
  String _earliestSched;
  String _walkinStart;
  String _walkinEnd;

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

          _loadData().then((data) {
            setState(() {

            });
          });
        });
      });
  }

  Widget build(BuildContext context) {
    
    if ( schedule == null ) {
      return LoadingScreen();
    }

    if ( this.data == null) {
      return LoadingScreen();
    }
    return Scaffold(
        // color for the whole page
        backgroundColor: Color.fromARGB(100, 107, 255, 245),
        appBar: AppBar(title: Text("To Previous Page")),

        body: Center(
          // center white box
          child: Container(
            color: Colors.white,
            height: 500,
            width: 700,
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Earliest Times Available',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 700,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: 
                      Text( this.data ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      DropdownButton(
                        hint: Text("Select option"),
                        value: _value,
                        onChanged: (value) => setState(() {
                          _value = value;
                        }),
                        items: storeSchedule.convertMenu(items)),
                      Container( 
                        padding: EdgeInsets.only(top: 20),
                        child:
                        FloatingActionButton.extended(
                          label: Text('Submit choice'),
                          onPressed: () => _onButtonPressed(1) ),
                          ),

                    ],),
                    
                    Container(child: 
                      FloatingActionButton.extended(
                        label: Text('Return to Previous Page'),
                        onPressed: () => _onButtonPressed(2) ),
                        ),
                  ],),
                  
                ],
              ),
          ),
        ),
      );
  }

_onButtonPressed(int option) async {

  // which button was pressed
  switch (option) {
    case 1: {

      // user did not select an option
      // notify user to select an option
      if ( _value == null ) {
        Fluttertoast.showToast(
          msg: 'Please select an option.',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          webPosition: 'center',
          );

      }
      else {
        // which option was selected
        switch (_value) {
          case 'A': {
            // use this for testing
            // ---------
            //_earliestSched = '11:00 - 11:15';
            // ---------
            int index = storeSchedule.timeSlots.indexOf(_earliestSched);
            storeSchedule.updateSelectedTimes(index, _earliestSched, true);
            double offset;

            if ( index > 19 && index <= 39 ) {
              offset = 320;
            }
            else if ( index > 39 && index <= 59 ) {
              offset = 640;
            }
            else {
              offset = 960;
            }


            return Navigator.push(context, MaterialPageRoute(
              builder: (context) => 
                StoreScheduleView(scheduleController: storeSchedule, 
                                  customerController: customerProfile, 
                                  scrollOffset: offset ),
              )
            );

          }
          break;
          case 'B': {
            String storeInfo = storeSchedule.getTextController('Store').text;
          List<String> storeInfoSplit = storeInfo.split(', ');
          String store = storeInfoSplit.first.split(',')[0];
          String address = storeInfoSplit.first.split(',')[1];
          String city = storeInfoSplit.first.split(',')[2];
          String state = storeInfoSplit.first.split(',')[3].replaceAll("\n", '');
          String day = storeSchedule.getTextController('day').text.toLowerCase();
          /*
          String storeCloseTime = 
            storeSchedule.timeSlots[storeSchedule.timeSlots.length-1].split(' - ').last.replaceAll(":", "");
          */
          //String maxCapacity = '100';
          String username = customerProfile.getTextController("username").text;
          String contact = customerProfile.getTextController("email").text;
          String partySize = customerProfile.getTextController("party_size").text;
          String visitLength = storeSchedule.selectedTimes.keys.length.toString();
          String type = 'scheduled';
          String option = 'B';
          String fullOrScheduledVisitStart = 'false';
          String nextTimeBlock = _walkinStart;
          String endTime = _walkinEnd;

          String customer = json.encode({
            username: {
              'contact_info': contact,
              'party_size': int.parse(partySize),
              'type':type, 
              'visit_length': int.parse(visitLength)
            }
          }).replaceAll("\"", "\\\"");

            String result = await Services.makeChoice(
                state,
                city,
                store,
                address,
                day,
                customer,
                option,
                fullOrScheduledVisitStart,
                nextTimeBlock,
                endTime);

            print(result);

          }
          break;

        }

      }

      

    }
    break;
    case 2: {

    }
  }
  


}

Future _loadSchedule() async {
    await storeSchedule.setSchedule();
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


    String visitStartBlock = 'ASAP';
    String storeCloseTime = 
      storeSchedule.timeSlots[storeSchedule.timeSlots.length-1].split(' - ').last.replaceAll(":", "");
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

  
  String temp = await Services.makeReservation(state,
                                               city,
                                               store,
                                               address,
                                               customer, 
                                               visitStartBlock, 
                                               storeCloseTime, 
                                               maxCapacity, 
                                               day);

  // Adding extra newline for readability
  List<String> tempList = temp.split('\n');
  String newTemp = '';

  for (int i = 0; i<tempList.length; i++) {

    newTemp += tempList[i] +  "\n\n";

  }
  temp = newTemp;

  /************** Get Times  **************************/

  // Earliest Reservation Time
  String tempTime = tempList[0].split(":").last.replaceAll(" ", "");
  String hour = tempTime.substring(0,2);
  String min = tempTime.substring(2);
  String startTime =  hour + ':' + min;

  // Calculate end time
  int minNum = int.parse(min);
  int hourNum = int.parse(hour);
  minNum += 15;

  if (minNum == 60) {
    min = '00';
    hourNum += 1;
  }

  min = minNum.toString();
  hour = hourNum.toString();
  if (hour.length < 2) {
    hour = '0' + hour;
  }

  String endTime = hour + ":" + min;

  // Build time slot for earliest reservation
  _earliestSched = startTime + ' - ' + endTime;
  //print(_earliestSched);

  /*
  int i = 0;
  for ( String item in tempList) {
    print('number: ' + i.toString());
    print(item);
    i++;
  }
  */
  List<String> walkinInfo = tempList[tempList.length - 2].split(':');

  _walkinStart = walkinInfo[1].split(' and ').first.replaceAll(" ", "");
  _walkinEnd = walkinInfo[2].replaceAll(' ', '');


  return this.data = temp;
}

  
}



