import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StatesView.dart';
import 'StoreScheduleView.dart';
import '../CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/rendering.dart';

class ScheduleVisit extends StatelessWidget{
  final CustomerProfileController customerProfile;
  ScheduleVisit({Key key, CustomerProfileController customerController, }) 
      : this.customerProfile = customerController, super(key: key);
    final _scrollController = ScrollController();
    final StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);
  @override
  Widget build(BuildContext context) {
    List<String> entries = customerProfile.favoriteStores;
    storeSchedule.getTextController('Store').text = '';
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Profile Page")),
      body:Center(
        child: Container(
          color: Colors.white,
          height:600,
          width: 1400,
           child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [

             Container(
               //padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
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

                    Column(
                      children:  [ 
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                        // Need both height and width or it won't render correctly
                        height: 200,
                        width: 200,
                        child: Scrollbar( 
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
                                tileColor: Colors.white,
                                title: Text(
                                  '${entries[index].split(", ").first}',
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
                      ),
                    ]
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          // Have to define this field or it throws a render error
                          width: 500,
                          color: Colors.white,
                          child: TextField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: storeSchedule.getTextController('Store'),
                            ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FloatingActionButton.extended(
                            heroTag: 'SelFavBtn',
                            onPressed: () => _onButtonPressed(context, 2),
                            label: Text(
                              'Select Store' ,
                            ),
                          )
                        )
                      ] 
                    ),

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: FloatingActionButton.extended(
                            heroTag: "LookupBtn",
                            onPressed: () => _onButtonPressed(context, 1),
                            label: Text(
                              "Store Lookup",
                            )
                          ),
                        ),
                      ],
                    ),

                  ], 
                ),
            ),
           ]
           
        ),
      )
    )
    ); 
  }


  _onTapped(String label){
    storeSchedule.getTextController('Store').text = label;
  }

  
  _onButtonPressed(BuildContext context, int option){

    if ( storeSchedule.getTextController('Store').text != '') {
      switch(option){
        case 1: {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => StatesView(customerController: customerProfile,),
            )
          );
        }
        break;
        case 2: {
          return Navigator.push(context, MaterialPageRoute(
            builder: (context) => StoreScheduleView(scheduleController: storeSchedule, customerProfile: customerProfile,),
            )
          );
        }
        break;
      }

    }

    else {

      Fluttertoast.showToast(
        msg: 'Please select a store.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        webPosition: 'center',
      );
    }
    
    return null;
  } 


  

}