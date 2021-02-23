import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SearchStoresController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'AddressesView.dart';
import '../CustomerProfile/CustomerProfileController.dart';

class StoresView extends StatelessWidget {
  static const String _title = 'Select a Store';
  static const String _label = 'Stores';
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  StoresView({Key key, SearchStoresController searchController, CustomerProfileController customerController}) 
      : this.menuItems = searchController, this.customerProfile = customerController, super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Select a City Page')),
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  _title,
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
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          alignment: Alignment.center,
                          child: MyStatefulWidget(searchController: menuItems, customerController: customerProfile, label: _label)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "StoresBtn",
                      onPressed: () => _onButtonPressed(context, 2),
                      label: Text(
                        "Select",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 224, 224, 224),
                    width: 3,
                    height: 100,
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
    return Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddressesView(searchController: menuItems, customerController: customerProfile),
      )
    );
  }
}
  
/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  List<String> dropDownList;
  String label;
  MyStatefulWidget({Key key, this.label, SearchStoresController searchController, CustomerProfileController customerController}) 
      :this.menuItems = searchController, this.customerProfile = customerController, super(key: key);
  @override
  _MyStatefulWidgetState createState() {
    //menuItems.setLabel( label );
    return _MyStatefulWidgetState(searchController: menuItems, customerController: customerProfile, label: label);
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  String label;
  _MyStatefulWidgetState({SearchStoresController searchController, CustomerProfileController customerController, String label})
       : this.menuItems = searchController, this.customerProfile = customerController, this.label = label;
  String dropdownValue; 
  

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(label),
      value: dropdownValue,
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
          dropdownValue = newValue;
          menuItems.setSelection('Store', dropdownValue);
        });
      },
      items: _displayMenu(),
    );
  }

  List<DropdownMenuItem<String>> _displayMenu(){
    return (
      menuItems.getMenuItems(widget.label)
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
        );
      }).toList()
    );
  }
}