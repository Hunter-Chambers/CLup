import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StoreSearch.dart';
import 'StoreScheduleView.dart';
import '../CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/rendering.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';

class ScheduleVisit extends StatelessWidget{


  final CustomerProfileController customerProfile;
  ScheduleVisit({CustomerProfileController customerController, }) 
                 : this.customerProfile = customerController;

  final StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);


  Widget build(BuildContext context) {
    return
    MaterialApp(
      home: MyScheduleVisitView(scheduleController: storeSchedule,
                              customerController: customerProfile),
      );}
}


class MyScheduleVisitView extends StatefulWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  final GlobalKey<FormState> _partySizeKey = new GlobalKey<FormState>();
  MyScheduleVisitView({StoreScheduleController scheduleController, 
                      CustomerProfileController customerController,
                      })
                      : this.storeSchedule = scheduleController,
                      this.customerProfile = customerController;

  @override
  _MyScheduleVisitViewState createState() => 
    _MyScheduleVisitViewState(scheduleController: storeSchedule,
                             customerController: customerProfile,
                             partySizeKey: _partySizeKey,
                             );
}

class _MyScheduleVisitViewState extends State<MyScheduleVisitView> {


  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  GlobalKey<FormState> _partySizeKey;
  _MyScheduleVisitViewState({StoreScheduleController scheduleController,
                              CustomerProfileController customerController, 
                              GlobalKey<FormState> partySizeKey})
                              : this.storeSchedule = scheduleController,
                               this.customerProfile = customerController,
                                this._partySizeKey = partySizeKey;

  String _selectedStore, _selectedAddress;
  

  @override
  Widget build(BuildContext context) {
    storeSchedule.getTextController('Store').text = '';
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Profile Page")),
      body:Center(
        child: Container(
          color: Colors.white,
          height:450,
          width: 1400,
           child: 
          
           /*****************************************************************  Left Column */
           ListView( 
             controller: new ScrollController(),
             children: [
              Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Container(
                   padding: EdgeInsets.only(top: 20),
                   child: 
                     Text(
                       'Choose a Store to Visit',
                       style: TextStyle(
                         fontSize: 50,
                         fontWeight: FontWeight.bold,
                          )
                     ),
                 ),
              
                  Container(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Expanded(
                        child: 
                          Column( 
                          children:  [ 
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Favorite Stores',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ),


                            Row( children: [                              
            /*****************************************************************  store drop down */
                              Expanded(child: 
                                Container(
                                  // Need both height and width or it won't render correctly
                                  //height: 200,
                                  //width: 200,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child:
                                    DropdownButton<String>(
                                      key: Key('FavoritesDrpDwn'),
                                      hint: Text("Choose a Store"),
                                      value: _selectedStore,
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
                                          _onTapped(newValue, 1);
                                        });
                                      },
                                      items: storeSchedule.convertMenu(customerProfile.getFavoriteStoreNames()),
                                    ),
                                  ),
                                  ),
                                ),
                              

            /*****************************************************************  address drop down */
                              Expanded(child: 
                                Container(
                                  // Need both height and width or it won't render correctly
                                  //height: 200,
                                  //width: 200,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child:
                                    DropdownButton<String>(
                                      key: Key('FavoritesDrpDwn'),
                                      hint: Text("Choose an Address"),
                                      value: _selectedAddress,
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
                                          _onTapped(newValue, 2);
                                        });
                                      },
                                      items: 
                                        storeSchedule.convertMenu(customerProfile.getFavoriteStoreAddresses(_selectedStore)),
                                    ),
                                  ),
                                ),
                              ),
                              

                            ]
                            ),
                       
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: FloatingActionButton.extended(
                                key: Key('selStrButton'),
                                heroTag: 'SelFavBtn',
                                onPressed: () => _onButtonPressed(context, 2),
                                label: Text(
                                  'Select Store' ,
                                ),
                              )
                            ),
                        ]
                        ),
                        ),
                        Expanded(
                        child: 
                          Column( 
                          children:  [ 
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Party Size',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                              child: TextFormField(
                                controller: customerProfile.getTextController("party_size"),
                                validator: (String value) {

                                  print(value);
                                  if (value.contains(new RegExp(r"[a-zA-Z'-]"))) {
                                    print(value);
                                    return "Must be a number.";
                                  }
                                  else {
                                    if (int.parse(value) > 6 || int.parse(value) < 1) {
                                      print(value);
                                      return "Must be greater than one and less than 6";
                                    }
                                  }
                                  
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter Party Size",
                                ),
                              ),
                            ),
                          ]

                          ),
                        ),
                        
                        Expanded(child: 
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '- OR -'  ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ]
                          ),
                        ),
                        
                        Expanded(child: 
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: FloatingActionButton.extended(
                                key: Key('strLookBtn'),
                                heroTag: "LookupBtn",
                                onPressed: () => _onButtonPressed(context, 1),
                                label: Text(
                                  "Store Lookup",
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: FloatingActionButton.extended(
                                key: Key('rtnProfBtn'),
                                heroTag: "Back to Profile",
                                onPressed: () => _onButtonPressed(context, 3),
                                label: Text(
                                  "Back to Profile",
                                )
                              ),
                            ),
                          ],
                        ),
                        ),

                      ], 
                    ),
                ),
               ]
               
            ),


             ]

           )

           
           )
           
      )
    );
  }


  _onTapped(String label, int option){
    setState(() {
      switch(option) {
        case 1: {
          _selectedStore = label;
          _selectedAddress = null;
        }
        break;
        case 2: {
          _selectedAddress = label;
        }
        break;
      }
    });
  }

  
  _onButtonPressed(BuildContext context, int option){
    if (_partySizeKey.currentState == null) {
      print("currentState is null");
    }
    else if(_partySizeKey.currentState.validate()) {
      switch(option){
        case 1: {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StoreSearch(customerController: customerProfile,),
              )
            );

        }
        break;
        case 2: {
          int partySize;
          if ( customerProfile.getTextController("party_size").text != null) {
            partySize = int.parse(customerProfile.getTextController("party_size").text);
            print(partySize);
          }
          else {
            partySize = -1;
            print(partySize);
          }
          if ( !(_selectedStore == null || _selectedAddress == null) &&
                (partySize > 1 && partySize < 6) ) {

            storeSchedule.getTextController("Store").text = 
              customerProfile.getFullStoreInfo(_selectedStore, _selectedAddress);


            return Navigator.push(context, MaterialPageRoute(
              builder: (context) => StoreScheduleView(scheduleController: storeSchedule, customerController: customerProfile,),
              )
            );
          }
          else {

            if (_selectedStore == null || _selectedAddress == null) {
              Fluttertoast.showToast(
                msg: 'Please select a store and an address.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                webPosition: 'center',
              );
            }
            else {
              Fluttertoast.showToast(
                msg: 'Party size must be between 1 and 5',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                webPosition: 'center',
              );

            }

          }
        }
        break;
        case 3: {

          return Navigator.push(context, MaterialPageRoute(
            builder: (context) => CustomerLogin(scheduleController: storeSchedule, customerController: customerProfile,),
            )
          );

        }
        break;
    }

    return null;
      
    }


    
    
  } 


  

}