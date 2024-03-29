import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/CustomerProfile/QR.dart';
import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayTimeSlots.dart';

class StoreScheduleView extends StatelessWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  StoreScheduleView({Key key, StoreScheduleController scheduleController, CustomerProfileController customerProfile}) 
      : this.storeSchedule = scheduleController, this.customerProfile = customerProfile,  super(key: key);

  Widget build(BuildContext context) {
    String storeName = storeSchedule.getTextController('Store').text.split(', ').first; 

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
                  storeName,
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
                  onPressed: () => _onButtonPressed(context),
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

    if (selectedTimes == '') 
      selectedTimes = 'Please select one or more consecutive times.';
    Fluttertoast.showToast(
      msg:  'Scheduled a visit for: ' + selectedTimes,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      webPosition: 'center',
    );

    _buildVisit(selectedTimes);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => QR(customerProfile: customerProfile)
    ));
  }

}