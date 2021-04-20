import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/CustomerProfile/QR.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';
import "package:clup/Services/Services.dart";
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'dart:convert';

class StoreScheduleView extends StatelessWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final double scrollOffset;
  StoreScheduleView({Key key,
                     StoreScheduleController scheduleController,
                     CustomerProfileController customerController,
                     double scrollOffset}) 
                     : this.storeSchedule = scheduleController,
                     this.customerProfile = customerController, 
                     this.scrollOffset = scrollOffset,
                     super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
        MyStoreScheduleView(scheduleController: storeSchedule,
                            customerController: customerProfile,
                            scrollOffset: scrollOffset),
      );}
}
class MyStoreScheduleView extends StatefulWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final double scrollOffset;
  MyStoreScheduleView({StoreScheduleController scheduleController,
                       CustomerProfileController customerController,
                       double scrollOffset})
                       : this.storeSchedule = scheduleController,
                       this.customerProfile = customerController,
                       this.scrollOffset = scrollOffset;

  @override
  _MyStoreScheduleViewState createState() => 
    _MyStoreScheduleViewState(scheduleController: storeSchedule,
                               customerController: customerProfile,
                               scrollOffset: scrollOffset);
    
}

class _MyStoreScheduleViewState extends State<MyStoreScheduleView> {
  List<String> data;
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final double scrollOffset;
  _MyStoreScheduleViewState({StoreScheduleController scheduleController,
                             CustomerProfileController customerController,
                             double scrollOffset})
                             : this.storeSchedule = scheduleController,
                             this.customerProfile = customerController,
                             this.scrollOffset = scrollOffset;

  @override
  void initState() {
    super.initState();
    _loadData().then((data) {
      setState(() {
        this.data = data;
      });
    });
  }

  Widget build(BuildContext context) {
    String fullStoreName = storeSchedule.getTextController('Store').text.split(', ').first; 
    String storeName = fullStoreName.split(',')[0] + ", " + fullStoreName.split(',')[1];
    String day = storeSchedule.getTextController('day').text;
    storeName += " - " + day;


    if( data == null ) {
      return LoadingScreen();
    }

    return Scaffold(
      //backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: SingleChildScrollView( 
        controller: new ScrollController(),
        child:
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
            Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child:
                Column ( children: <Widget>[
                  Expanded(child: 
                    Container (
                      color: Color.fromARGB(100, 107, 255, 245),
                    ),
                  ),
                ],
                ),
              ),
               // left column
              Column(children: [
                Expanded(child: 
                  Container(
                    width: 900,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Center(child: 
                      Text(
                        storeName,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ) ,
                      ),
                    )
                  ),
                ),

                DisplayTimeSlots(scheduleController: storeSchedule,
                                 customerController: customerProfile,
                                 scrollOffset: scrollOffset,),

                Expanded(child: 
                  Container(
                    width: 900,
                    color: Colors.white,
                    //padding: EdgeInsets.fromLTRB(110, 70, 110, 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      FloatingActionButton.extended(
                        heroTag: 'SchedTimesBtn',
                        key: Key('subSchedBtn'),
                        onPressed: () => _onButtonPressed(context, 1),
                        label: Text(
                          '            Schedule Times            ',
                        ),
                      ),

                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        
                        Container(
                          padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                          child: 
                          FloatingActionButton.extended(
                            heroTag: 'schedToVisit',
                            key: Key('schedToVisit'),
                            onPressed: () => _onButtonPressed(context, 2),
                            label: Text(
                              '    Return to Previous Page    ',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: 
                          FloatingActionButton.extended(
                            heroTag: 'schedToProf',
                            key: Key('schedToProf'),
                            onPressed: () => _onButtonPressed(context, 3),
                            label: Text(
                              '    Return to Profile Page    ',
                            ),
                          ),
                        ),


                      ],),

                    ],),


                 )
                ),

              ]),
              /*
              Center(
                child: Container (
                  color: Color.fromARGB(100, 107, 255, 245),
                  alignment: Alignment.center,
                  height: 800,
                  width: 1000,
                  child: SingleChildScrollView(
                    child: Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [



                      //Expanded(child: 
                      //),

                    //
                    //
                    ],
                  )
                ,)
                )
              ),
              */
              Expanded(child: 
                Column (children: <Widget>[
                  Expanded(child: 
                    Container (
                      color: Color.fromARGB(100, 107, 255, 245),
                    ),
                  ),
                ],
                ),
              ), // right column
            ],
          ),
          ),
        

      ),

         // outermost row
      
        
    );
  }


  Future _loadData() async{
    await storeSchedule.setSchedule();
    return this.data = storeSchedule.timeSlots;
  }

  Future<bool> _buildVisit(String selectedTimes) async{
    //String visit = selectedTimes + ';';
    String visit = '';
    String storeInfo = storeSchedule.getTextController('Store').text;
    List<String> storeInfoSplit = storeInfo.split(', ');
    String store = storeInfoSplit.first.split(',')[0];
    String address = storeInfoSplit.first.split(',')[1];
    String city = storeInfoSplit.first.split(',')[2];
    String state = storeInfoSplit.first.split(',')[3].replaceAll("\n", '');
    String visitStartTime = selectedTimes.split(' - ').first;
    String visitEndTime = selectedTimes.split(' - ').last;
    String visitStartBlock = visitStartTime.replaceAll(":", "");
    //String visitEndBlock = visitEndTime.replaceAll(":", "");
    String storeCloseTime = 
      storeSchedule.timeSlots[storeSchedule.timeSlots.length-1].split(' - ').last.replaceAll(":", "");
    //String maxcapacity = storeProfile.getTextController("max_capacity");
    String maxCapacity = '100';
    String username = customerProfile.getTextController("username").text;
    String contact = customerProfile.getTextController("email").text;
    String partySize = customerProfile.getTextController("party_size").text;
    String visitLength = storeSchedule.selectedTimes.keys.length.toString();
    String type = 'scheduled';
    String day = storeSchedule.getTextController('day').text.toLowerCase();


    
    String customer = json.encode({
      username: {
        'contact_info': contact,
        'party_size': int.parse(partySize),
        'type':type, 
        'visit_length': int.parse(visitLength)
      }
    }).replaceAll("\"", "\\\"");
    
    //print(state);
    //print(city);
    //print(store);
    //print(address);
    //print(customer);
    //print(visitStartBlock);
    //print(storeCloseTime);
    //print(maxCapacity);

    visit += '"' + username + ';' + 
        contact + ';' + 
        partySize + ';' + 
        type + ';' +
        visitLength + ';' +
        visitStartTime + ";" +
        visitEndTime + ';' +
        store + ';' +
        day + '"';
    
    //print("visit: " +  visit);
    

    Services.makeReservation(state,
                                 city,
                                 store,
                                 address,
                                 customer,
                                 visitStartBlock,
                                 storeCloseTime,
                                 maxCapacity,
                                 day
                                 );
    String output = await _saveVisit(username, visit);
    if ( output.contains('success') ) {
      customerProfile.addvisit(visit);
      return true;
    }
    else if ( output.contains('already')) {
      return false;
    }
    else {
      print('Something happened');
      return false;
    }




    
  }

  Future<String> _saveVisit(String username, String visit) async{
      return await Services.addVisit(username, visit);

  }

  _onButtonPressed(BuildContext context, int option) async{
    String selectedTimes = storeSchedule.getSelectedTimes();

    switch (option) {
      case 1: {
        if (selectedTimes == '') {
                selectedTimes = 'Please select one or more consecutive times.';
              Fluttertoast.showToast(
                msg: selectedTimes,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                webPosition: 'center',
              );
            }

            else{
              bool newVisit = await _buildVisit(selectedTimes);

              if (newVisit) {

                Fluttertoast.showToast(
                  msg:  'Scheduled a visit for: ' + selectedTimes,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  webPosition: 'center',
                );     
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => QR(customerProfile: customerProfile)
                ));

              }

              else {

                Fluttertoast.showToast(
                  msg:  'Visit already exists.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  webPosition: 'center',
                );     

              }

           }
      }
      break;

      case 2: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ScheduleVisit(customerController: customerProfile)
        ));

      }
      break;

      case 3: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CustomerLogin(customerController: customerProfile,
                                              scheduleController: storeSchedule,)
        ));

      }
      break;
    }
  }
}
    