import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/CustomerProfile/QR.dart';
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';
import "package:clup/Schedule/LoadingScreen.dart";
import "package:clup/testing/Services.dart";

class StoreScheduleView extends StatelessWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  StoreScheduleView({Key key, StoreScheduleController scheduleController, CustomerProfileController customerController}) 
      : this.storeSchedule = scheduleController, this.customerProfile = customerController,  super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStoreScheduleView(scheduleController: storeSchedule, customerController: customerProfile),
      );}
}
class MyStoreScheduleView extends StatefulWidget {
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  MyStoreScheduleView({StoreScheduleController scheduleController, CustomerProfileController customerController})
  : this.storeSchedule = scheduleController, this.customerProfile = customerController;

  @override
  _MyStoreScheduleViewState createState() => 
    _MyStoreScheduleViewState(scheduleController: storeSchedule, customerController: customerProfile);
    
}

class _MyStoreScheduleViewState extends State<MyStoreScheduleView> {
  List<String> data;
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  _MyStoreScheduleViewState({StoreScheduleController scheduleController, CustomerProfileController customerController})
  : this.storeSchedule = scheduleController, this.customerProfile = customerController;

  @override
  void initState() {
    super.initState();
    //print("setting schedule");
    _loadData().then((data) {
      setState(() {
        this.data = data;
    });
    });
  }

  Widget build(BuildContext context) {
    String storeName = storeSchedule.getTextController('Store').text.split(', ').first; 

    /*
    if (storeName == 'Walmart') 
      storeSchedule.setWalmart();
    else if(storeName == 'HEB'){
      storeSchedule.setHEB();
    }
    else if(storeName == 'United Supermarkets'){
      storeSchedule.setUnited();
    }
    else if (storeName == 'Albertsons'){
      storeSchedule.setAlbertsons();
    }
    */
    if( data == null ) {
      return LoadingScreen(scheduleController: storeSchedule, customerController: customerProfile,);
    }
    //print("Printing data: ");
    //print(data);



    //storeSchedule.setAlbertsons();
    //storeSchedule.setWalmart();

    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Center(
        child: Container (
          color: Colors.white,
          alignment: Alignment.center,
          height: 800,
          width: 1000,
          child: SingleChildScrollView(
            child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Text(
                  storeName,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ) ,
                )
              ),

              DisplayTimeSlots(scheduleController: storeSchedule, customerController: customerProfile),

                        Container(
                child: Divider(
                )
              ),

              Container(
                padding: EdgeInsets.only(top: 10),
                child: FloatingActionButton.extended(
                  heroTag: 'SchedTimesBtn',
                  key: Key('subSchedBtn'),
                  onPressed: () => _onButtonPressed(context),
                  label: Text(
                    'Schedule Times',
                  ),
                )
              )
            ],
          )
        ,)
        )
      ),
        
    );
  }


  Future _loadData() async{
    await storeSchedule.setSchedule();
    return this.data = storeSchedule.timeSlots;
  }

  _buildVisit(String selectedTimes) {
    String visit = selectedTimes + ';';
    String storeInfo = storeSchedule.getTextController('Store').text;

    List<String> storeInfoSplit = storeInfo.split(', ');

    visit += customerProfile.getTextController("username").text +
        ';' +
        customerProfile.getTextController("email").text + ';';
    
    for (String info in storeInfoSplit){
      visit += info + ';';
    }
    /*
    Fluttertoast.showToast(
      msg:  visit,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      webPosition: 'center',
    );
    */
    customerProfile.addvisit(visit);
  }

  _onButtonPressed(BuildContext context) {
    String selectedTimes = storeSchedule.getSelectedTimes();

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
      _buildVisit(selectedTimes);
      String state = "something";
      String city = "something";
      String store = "something";
      String address = "something";
      String partySize = customerProfile.getTextController("party_size").text;
      Services.updateSchedule(state, city, store, address, selectedTimes, partySize);
      
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
  }

}