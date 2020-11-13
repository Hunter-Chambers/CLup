/*
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SearchStoresController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchStoresView extends StatelessWidget {
  static const String _title = 'Lookup A Store';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.center,
              child: MyStatefulWidget(label: 'States')),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.center,
              child: MyStatefulWidget(label: 'Cities')),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.center,
              child: MyStatefulWidget(label: 'Stores')),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              alignment: Alignment.center,
              child: MyStatefulWidget(label: 'Addresses')),
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  SearchStoresController menuItems = SearchStoresController();
  List<String> dropDownList;
  String label;
  MyStatefulWidget({Key key, this.label}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() {
    menuItems.setLabel( label );
    return _MyStatefulWidgetState(controller: menuItems, label: label);
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SearchStoresController menuItems;
  String label;
  _MyStatefulWidgetState({SearchStoresController controller, String label}) : this.menuItems = controller, this.label = label;
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
          _updateDropDown(dropdownValue);
        });
      },
      items: _action(dropdownValue), //null
    );
  }

  _updateDropDown(String selectedValue){
    menuItems.setSelection(label, selectedValue);
    menuItems.setSelectedTrue(label);
    }
  }

  List <DropdownMenuItem<String>>_action( String selectedValue){
    Fluttertoast.showToast(
      msg: 'HI',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    
    if ( menuItems.getSelected("Stores") ) {
      // show addresses
      option = 1;
    }
    else if ( menuItems.getSelected("Cites") ) {
      // show stores
      option = 2;
    }
    else if ( menuItems.getSelected("States") ) {
      // show cities
      option = 3;
    }
    else {
      // show states
      option = 4;
    }
    switch (option) {
      case 'States' : {
        return _displayMenu();
      }
      break;
      case 'Cities' : {
        if( menuItems.getSelection(option) == 'Oklahoma') {
          menuItems.setMenuItems('Cities', ['Norman', 'OK City', 'Stillwater']);
          return _displayMenu();
        }
        else return null;
      }
    }
    return null;
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
*/