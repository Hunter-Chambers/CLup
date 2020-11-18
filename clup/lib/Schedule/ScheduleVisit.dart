import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StatesView.dart';
import 'StoreScheduleView.dart';
import '../CustomerProfile/CustomerProfileController.dart';

class ScheduleVisit extends StatelessWidget{
  CustomerProfileController customerProfile;
  ScheduleVisit({Key key, CustomerProfileController controller}) : this.customerProfile = controller, super(key: key);
    List<String> entries; //<String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    final List<int> colorCodes = <int>[600, 500, 100];
    final _scrollController = ScrollController();
    StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);
  @override
  Widget build(BuildContext context) {
    entries = customerProfile.favoriteStores;
    storeSchedule.getTextController('Store').text = 'Choose a Store to the Left';
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Profile Page")),
      body: Column(children: [
        Container(
          //padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: 
            Text(
              'Choose from Favorite Stores',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                 )
            ),
          ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Divider(
            thickness: 3,)
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 200,
              child: Center(
                child: Text(
                  'Favorite Stores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                  ),
              )
            ),
            Expanded( child: Container(
              // Need both height and width or it won't render correctly
              height: 200,
              width: 200,
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Scrollbar( 
                controller: _scrollController,
                isAlwaysShown: true,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        '${entries[index]}',
                        textAlign: TextAlign.center,
                        ),
                      onTap: () => _onTapped(entries[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              )
            ) ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Divider(
            thickness: 3,)
        ),
        Container(
          child: 
            Text(
              'OR Lookup a Store',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                 )
            ),
          ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Divider(
            thickness: 3,)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: FloatingActionButton.extended(
            heroTag: "LookupBtn",
            onPressed: () => _onButtonPressed(context, 1),
            label: Text(
              "Lookup a Store",
            )
          ),
        ),
        ],
      )
    ); 
  }
  _onTapped(String label){
    storeSchedule.getTextController('Store').text = label;
  }
  
  _onButtonPressed(BuildContext context, int option){

    switch(option){
      case 1: {
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) => StatesView(),
          )
        );
      }
      break;
      case 2: {
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) => StoreScheduleView(controller: storeSchedule),
          )
        );
      }
      break;
    }
    return null;
  } 
}