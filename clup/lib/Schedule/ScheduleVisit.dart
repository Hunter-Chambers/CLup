import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StoreSearch.dart';
import 'StoreScheduleView.dart';
import '../CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/rendering.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';
import 'ASAP.dart';
import 'package:clup/Services/Services.dart';
import 'dart:convert';

class ScheduleVisit extends StatelessWidget{


  final CustomerProfileController customerProfile;
  ScheduleVisit({Key key, CustomerProfileController customerController, }) 
                 : this.customerProfile = customerController, super(key: key);

  final StoreScheduleController storeSchedule = new StoreScheduleController(['Store', 'day']);


  Widget build(BuildContext context) {
    return
    MaterialApp(
      home: MyScheduleVisitView(scheduleController: storeSchedule,
                              customerController: customerProfile,
      )
      );}
}


class MyScheduleVisitView extends StatefulWidget {
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  MyScheduleVisitView({StoreScheduleController scheduleController, 
                      CustomerProfileController customerController,
                      GlobalKey<FormState> partySizeKey,
                      })
                      : this.storeSchedule = scheduleController,
                      this.customerProfile = customerController;

  @override
  _MyScheduleVisitViewState createState() => 
    _MyScheduleVisitViewState(scheduleController: storeSchedule,
                             customerController: customerProfile,
                             );
}

class _MyScheduleVisitViewState extends State<MyScheduleVisitView> {


  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  final _partySizeKey = GlobalKey<FormState>();
  _MyScheduleVisitViewState({
                             StoreScheduleController scheduleController,
                              CustomerProfileController customerController, 
                              })
                              : this.storeSchedule = scheduleController,
                               this.customerProfile = customerController;

  String _selectedStore, _selectedAddress, _selectedDay;
  List<String> data;
  bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = false;
    storeSchedule.setDays();
    _selectedDay = storeSchedule.days[0];
    storeSchedule.getTextController('day').text = _selectedDay.replaceAll("Today - ", "");
    _loadData().then((data) {
      setState(() {
        this.data = data;
      });
    });
  }

  

  

  @override
  Widget build(BuildContext context) {
    storeSchedule.getTextController('Store').text = '';
    
    if( data == null ) {
      return LoadingScreen(scheduleController: storeSchedule, customerController: customerProfile,);
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Profile Page")),
      body: SingleChildScrollView(
        child:
          Center(
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
                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                            //Expanded(
                            //child: 
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
                                Container(
                                  width: 800,
                                  child:
                                  Row( 
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [                              
                /*****************************************************************  store drop down */
                                  //Expanded(child: 
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child:
                                        DropdownButton<String>(
                                          key: Key('FavStrDrpDwn'),
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
                                    //),
                                //  

                /*****************************************************************  address drop down */
                                  //Expanded(child: 
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child:
                                        DropdownButton<String>(
                                          key: Key('FavAddrDrpDwn'),
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
                                  //),

                /*****************************************************************  days drop down */
                                  //Expanded(child: 
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child:
                                        DropdownButton<String>(
                                          key: Key('DaysDrpDwn'),
                                          hint: Text("Choose a Day"),
                                          value: _selectedDay,
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
                                              _onTapped(newValue, 3);
                                            });
                                          },
                                          items: 
                                            storeSchedule.convertMenu(storeSchedule.days),
                                        ),
                                      ),
                                    ),
                                  //),
                              //  

                                ]
                                ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                    Container (
                                      padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                                      child: Text("Enter store as soon as possible")
                                      ),
                                    Container(
                                      padding: EdgeInsets.only(top:20),
                                      child: Checkbox(
                                        value: _isChecked,
                                        onChanged: (value) => setState( () {
                                          print(value);

                                          _isChecked = value;
                                         }),
                                       )
                                     ),
                                ],
                                ),
                           
                                
                            ]
                            ),
                            //),
                            Container(
                              width: 200,
                              child:
                              //Expanded(
                                //child: 
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
                                      //margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                      child: Form(
                                        key: _partySizeKey,
                                        child: TextFormField(
                                          controller: customerProfile.getTextController("party_size"),
                                          validator: (String value) {

                                            if (value.contains(new RegExp(r"[a-zA-Z'-]"))) {
                                              return "Must be a number.";
                                            }
                                            else {
                                              if (int.parse(value) > 5 || int.parse(value) < 1) {
                                                return "Must be greater\nthan 1 and less\nthan 6";
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

                                    ),
                                    
                                  ]

                                  ),
                                ),
                              //),
                          //  
                          //  
                            //Expanded(child: 
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
                            //),
                        //  
                            //Expanded(child: 
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
                            //),

                          ], 
                        ),
                    ),
                   ]
                   
                ),


                 ]

               )

               
               )
               
          )
         ),
      
    );
  }

  Future _loadData() async{
    await customerProfile.getFavoriteStores();
    return this.data = customerProfile.favoriteStores;
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
        case 3: {
          _selectedDay = label;
          storeSchedule.getTextController('day').text = _selectedDay.replaceAll("Today - ", "");
        }
        break;
      }
    });
  }

  
  _onButtonPressed(BuildContext context, int option ) async{
    _isChecked;

    if ( customerProfile.getTextController("party_size").text != "") {
      _partySizeKey.currentState.validate();
    }
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
        if ( customerProfile.getTextController("party_size").text != "") {
          partySize = int.parse(customerProfile.getTextController("party_size").text);
        }
        else {
          partySize = -1;
        }
        if ( !(_selectedStore == null || _selectedAddress == null) &&
              (partySize > 0 && partySize < 6) ) {

          storeSchedule.getTextController("Store").text = 
            customerProfile.getFullStoreInfo(_selectedStore, _selectedAddress);

          if (_isChecked) {

            
            for (String day in storeSchedule.days ) {
              if ( day.contains('Today') ) {
                day = day.replaceAll('Today - ', '').toLowerCase();
                storeSchedule.getTextController('day').text = day;
              }
            }

            return Navigator.push(context, MaterialPageRoute(
              builder: (context) => ASAP(scheduleController: storeSchedule, customerController: customerProfile, ),
              )
            );

          }


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

/*
class SubmitButton extends StatelessWidget {
  final VoidCallback onClick;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  SubmitButton({Key key, this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _formKey.currentState.validate();
    return GestureDetector(
      onTap: onClick,
      child:Container(

        //your button
    ),
    );
  }
}
*/