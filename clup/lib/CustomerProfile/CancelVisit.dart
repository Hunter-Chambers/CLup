//import 'package:clup/SearchStoresView_Backup.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'package:clup/Services/Services.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'HeroDialogRoute.dart';
import 'ConfirmCancelPopupCard.dart';

class CancelVisit extends StatefulWidget {
  final CustomerProfileController customerProfile;

  CancelVisit({Key key, this.customerProfile,})
      : super(key: key);

  @override
  _CancelVisitState createState() => _CancelVisitState(
        customerController: customerProfile,
      );
}


class _CancelVisitState extends State<CancelVisit> {
  CustomerProfileController customerProfile;
  String _dropDownValue;
  List<String> data;
  List<String> dropDownItems = [];
  _CancelVisitState({CustomerProfileController customerController,}) 
    : this.customerProfile = customerController;

  @override
  void initState() {
    super.initState();

    _loadVisits().then((data) {
      setState(() {
        this.data = data;

        _loadData();
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    if( data == null ) {
      return LoadingScreen();
    }
    return Scaffold(
        // color for the whole page
        backgroundColor: Color.fromARGB(100, 107, 255, 245),
        appBar: AppBar(title: Text("To Previous Page")),

        body: SingleChildScrollView(
          child: 
            Container(
              height:MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              child:
              Center(
              child: Container(
                color: Colors.white,
                height: 400,
                width: 700,
                child:
                Column(
                  children: [
                    Container(
                       padding: EdgeInsets.only(top: 20),
                       child:Text(
                      "Cancel a Visit",
                      style: TextStyle(
                        fontSize:50,
                        fontWeight:FontWeight.bold,
                         ),
                      ), 
                    ),
                    
                    
                    Container(
                      padding:EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: DropdownButton<String>(
                      itemHeight: 75,
                      key: Key('AddressDrpDwn'),
                      hint: Text('Select a visit'),
                      value: _dropDownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _dropDownValue = newValue;
                        });
                      },
                      items:  dropDownItems?.map<DropdownMenuItem<String>>((dynamic value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      })?.toList() ??
                      []),
                    ),
                     
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
                      child: FloatingActionButton.extended(
                        heroTag: "CusSignOutBtn",
                        onPressed: () => _onButtonPressed(context, 1),
                        label: Text(
                          "Cancel selected visit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
                      child: FloatingActionButton.extended(
                        heroTag: "CanclToProf",
                        onPressed: () => _onButtonPressed(context, 2),
                        label: Text(
                          "Return to profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                  // Signout button
                ),
              ),
            ),
          ),
    );
  }

  Future _loadVisits() async{
    await customerProfile.getVisits();
    return this.data = customerProfile.visits;
  }
  _loadData() {
    dropDownItems = [];
    if (customerProfile.visits.first != 'no visits\n') {
      for (String visit in customerProfile.visits) {
        List<String> info = visit.split(';');
        dropDownItems.add(
            info[5] + " - " + info[6] + "\n" + info[7] + "\n on " + info[8]);
            //visit);
      }

      // correctly initialize dropDownValue
      _dropDownValue = dropDownItems[0];
    } else {
      dropDownItems = [];
      _dropDownValue = null;
    }

  }


  _onButtonPressed(BuildContext context, int option) async {
    switch (option) {
      case 1: {
 
        if (_dropDownValue != null) {
          List<String> tempList = _dropDownValue.split('\n');
          for (String visit in customerProfile.visits) {
            print(visit);
            if (visit.contains(tempList[0].split(' - ').first) &&
                visit.contains(tempList[0].split(' - ').last) &&
                visit.contains(tempList[1]) &&
                visit.contains(tempList[2].replaceAll(" on ", ""))) {

               await Navigator.of(context).push(HeroDialogRoute (
                  builder: (context) {
                    return ConfirmCancelPopupCard(visit: visit, customerController: customerProfile,);
                  },
              ));


              _loadVisits().then((data) {
                    setState(() {
                      print('setting state');
                      this.data = data;
                      print(this.data);

                      _loadData();
                });
              });

              print('Made it here');
              return LoadingScreen();

              //Services.cancelVisit(visit);
            }
          }
          

          /*
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CustomerLogin(customerController: customerProfile),
            ));
          */

        }
        else {
          Fluttertoast.showToast(
            msg: 'Must select a visit to cancel.',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            webPosition: 'center',
            );
        }

      }
      break;
      case 2: {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CustomerLogin(customerController: customerProfile),
        ));



      }
      break;
      return null;
    }
  }
}
