import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../StoreSearch/StatesView.dart';
import 'StoreScheduleView.dart';

class ScheduleVisit extends StatelessWidget{
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    final List<int> colorCodes = <int>[600, 500, 100];
    final _scrollController = ScrollController();
    StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);
  @override
  Widget build(BuildContext context) {
    storeSchedule.getTextController('Store').text = 'initialValue';
    return Scaffold(
      appBar: AppBar(title: Text("To Profile Page")),
      body: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
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
            Container(
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
                      tileColor: Color.fromARGB(100, 0, 0, 500),
                      title: Text('Store Name: ${entries[index]}'),
                      onTap: () => _onTapped(entries[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              )
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  // Have to define this field or it throws a render error
                  width: 500,
                  color: Color.fromARGB(100, 1000, 0, 0),
                  child: TextField(
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