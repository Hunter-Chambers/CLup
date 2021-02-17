import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SearchStoresController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'CitiesView.dart';
import '../CustomerProfile/CustomerProfileController.dart';
import 'DropDown.dart';

class StatesView extends StatelessWidget {
  //final String _title = 'Select a State';
  //final String _label = 'States';

  CustomerProfileController customerProfile;
  SearchStoresController menuItems = SearchStoresController();
  StatesView ({Key key, CustomerProfileController customerController}) : this.customerProfile = customerController, super(key: key);

  Widget build(BuildContext context) {
    return 
    MaterialApp(
      home: MyStatesView(searchController: menuItems,),
    );}
}

class MyStatesView extends StatefulWidget{
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  MyStatesView({SearchStoresController searchController, CustomerProfileController customerController })
  : this.menuItems = searchController, this.customerProfile = customerController;
  
  @override
   _MyStatesViewState createState() => _MyStatesViewState(searchController: menuItems, customerController: customerProfile);

}

class _MyStatesViewState extends State<MyStatesView>{
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  _MyStatesViewState({SearchStoresController searchController, CustomerProfileController customerController})
  : this.menuItems = searchController, this.customerProfile = customerController;
   Widget build(BuildContext context ) {
      return Scaffold(
      appBar: AppBar(title: Text('To Login Page')),
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500,
          width: 1000,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  'Search for a Store',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    height: 50,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 50),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder:(context, index) { 
                        return Padding(
                          padding: EdgeInsets.only(right: 20),
                        child: DropDown(searchController: menuItems, customerController: customerProfile, index: index)
                        );
                    }, 
                    ),
                  ),
                  
                  Container(
                    color: Color.fromARGB(255, 224, 224, 224),
                    width: 3,
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "StateBtn",
                      onPressed: () => _onButtonPressed(context, 2),
                      label: Text(
                        "Select",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 35, 50, 52),
              ),
            ],
          ),
        ),
      ),
    );
   }
  _onButtonPressed(BuildContext context, int option){
    setState(() {
      
    });
    /*
    return Navigator.push(context, MaterialPageRoute(
      builder: (context) => CitiesView(searchController: menuItems, customerController: customerProfile,),
      )
      
    );
    */
    }
}