import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SearchStoresController.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'CitiesView.dart';
import '../CustomerProfile/CustomerProfileController.dart';


class DropDown extends StatefulWidget {
  List<String> labels = ['States', 'Cities', 'Stores', 'Addresses'];
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  List<String> dropDownList;
  String label;
  int index;
  DropDown({Key key, this.index, SearchStoresController searchController, CustomerProfileController customerController}) 
      :this.menuItems = searchController, this.customerProfile = customerController, super(key: key);
  @override
  _DropDownState createState() {
    label = labels[this.index];
    menuItems.setLabel( label );
    return _DropDownState(searchController: menuItems, customerController: customerProfile, label: label);
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownState extends State<DropDown> {
  SearchStoresController menuItems;
  CustomerProfileController customerProfile;
  String label;
  _DropDownState({this.label, SearchStoresController searchController, CustomerProfileController customerController}) 
      :this.menuItems = searchController, this.customerProfile = customerController;
  String dropdownValue; 
  

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      key: Key('StateDrpDwn'),
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
          menuItems.setSelection('State', dropdownValue);
          menuItems.whichState();
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