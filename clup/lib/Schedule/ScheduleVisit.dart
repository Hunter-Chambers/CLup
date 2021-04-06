import 'dart:convert';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StoreSearch.dart';
import 'StoreScheduleView.dart';
import '../CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/rendering.dart';

class ScheduleVisit extends StatelessWidget{
  final CustomerProfileController customerProfile;
  ScheduleVisit({Key key, CustomerProfileController customerController, }) 
      : this.customerProfile = customerController, super(key: key);
    final _scrollController = ScrollController();
    final StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);
  Widget build(BuildContext context) {
    return
    MaterialApp(
      home: MyScheduleVisitView(scheduleController: storeSchedule, customerController: customerProfile),
      );}
}
class MyScheduleVisitView extends StatefulWidget {
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  MyScheduleVisitView({StoreScheduleController scheduleController, CustomerProfileController customerController})
  : this.storeSchedule = scheduleController, this.customerProfile = customerController;

  @override
  _MyScheduleVisitViewState createState() => 
    _MyScheduleVisitViewState(scheduleController: storeSchedule, customerController: customerProfile);
}

class _MyScheduleVisitViewState extends State<MyScheduleVisitView> {
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  _MyScheduleVisitViewState({StoreScheduleController scheduleController, CustomerProfileController customerController})
  : this.storeSchedule = scheduleController, this.customerProfile = customerController;
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
                            
                       
           /*****************************************************************  store tiles */
                            /*
                            Scrollbar( 
                              controller: _scrollController,
                              isAlwaysShown: true,
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount: entries.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container (
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                    child: ListTile(
                                    key: Key('storeTile'),
                                    tileColor: Colors.white,
                                    title: Text(
                                      "${entries[index].split(',').first}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                    onTap: () => _onTapped(entries[index]),
                                  )
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider(),
                              )
                            )
                            */
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
                       /* 
                        Expanded(child: 
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            /*
                            Container(
                              // Have to define this field or it throws a render error
                              width: 500,
                              color: Colors.white,
                              child: TextField(
                                key: Key('selectedStore'),
                                textAlign: TextAlign.center,
                                readOnly: true,
                                controller: storeSchedule.getTextController('Store'),
                                ),
                            ),
                            */

                            
                          ] 
                          ),
                        ),
                        */
                        
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
                              child: FloatingActionButton.extended(
                                key: Key('strLookBtn'),
                                heroTag: "LookupBtn",
                                onPressed: () => _onButtonPressed(context, 1),
                                label: Text(
                                  "Store Lookup",
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

      switch(option){
        case 1: {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StoreSearch(customerController: customerProfile,),
              )
            );
          
        }
        break;
        case 2: {
          if ( !(_selectedStore == null || _selectedAddress == null)) {
            storeSchedule.getTextController("Store").text = 
              customerProfile.getFullStoreInfo(_selectedStore, _selectedAddress);
            print(storeSchedule.getTextController("Store").text);

            return Navigator.push(context, MaterialPageRoute(
              builder: (context) => StoreScheduleView(scheduleController: storeSchedule, customerController: customerProfile,),
              )
            );
          }
          else {
           Fluttertoast.showToast(
             msg: 'Please select a store and an address.',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             webPosition: 'center',
           );
          }
        }
        break;
        
      }


    
    
    return null;
  } 


  

}