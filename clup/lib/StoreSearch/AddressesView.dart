import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SearchStoresController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import '../CustomerProfile/CustomerProfileController.dart';

class AddressesView extends StatelessWidget {
  static const String _title = 'Select an Address';
  static const String _label = 'Addresses';
  final SearchStoresController menuItems;
  final CustomerProfileController customerProfile;
  AddressesView({Key key, SearchStoresController searchController, CustomerProfileController customerController}) 
      : this.menuItems = searchController, this.customerProfile = customerController, super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Select a Store Page')),
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
                    padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
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
                    padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                    child: Builder(
                      builder: (context) =>
                        Center(
                          child: FloatingActionButton.extended(
                            heroTag: 'AddressBtn',
                            onPressed: () => _onButtonPressed(context, 1),
                            label: Text(
                              "Add",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            )
                          ),
                        )
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
                      heroTag: 'RetLogBtn',
                      onPressed: () => _onButtonPressed(context, 2),
                      label: Text(
                        "To Profile Page",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    )
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
            ],
          ),
        ),
      ),
    );
  }
  _onButtonPressed(BuildContext context, int option){

    switch (option) {
      case 1: {
        String storeSelection = menuItems.getSelection('Store') + ', ' + 
        menuItems.getSelection('Address') + ', ' + 
        menuItems.getSelection('City') + ', ' + 
        menuItems.getSelection('State');

        customerProfile.addFavoriteStore(storeSelection);
        String msg = storeSelection + ' was added to Favorites';

    
        final snackBar = SnackBar(content: Text(msg));

        Scaffold.of(context).showSnackBar(snackBar);
      }
      break;
      case 2: {
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) => CustomerLogin(customerController: customerProfile,),
          )
        );
      }
      break;
    }

    return null;

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
    menuItems.setLabel( label );
    return _MyStatefulWidgetState(searchController: menuItems, customerConrtoller: customerProfile, label: label);
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  String label;
  _MyStatefulWidgetState({SearchStoresController searchController, String label, CustomerProfileController customerConrtoller}) 
      : this.menuItems = searchController, this.customerProfile = customerConrtoller, this.label = label;
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
          menuItems.setSelection('Address', dropdownValue);
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