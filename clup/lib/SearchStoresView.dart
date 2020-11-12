import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchStoresView extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final List<String> stateList = ["Texas", "Oklahoma", "New Mexico", ''];
  final List<String> cityList = ["Amarillo", "Lubbock", "Dallas", ''];
  final List<String> storeList = ["Walmart", "United", "Albertons", "HEB", ''];
  final List<String> addressList = ["111 SomeLane", "222 SomeRoad", "333 SomeStreet", ''];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: Container(
            child: ListView(
             scrollDirection: Axis.horizontal,
             children: [
               Container(
                 alignment: Alignment.center,
                 child: MyStatefulWidget(dropDownList: stateList)),
               Container(
                 alignment: Alignment.center,
                 child: MyStatefulWidget(dropDownList: cityList)),
               Container(
                 alignment: Alignment.center,
                 child: MyStatefulWidget(dropDownList: storeList)),
               Container(
                 alignment: Alignment.center,
                 child: MyStatefulWidget(dropDownList: addressList)),
            ],),
          ),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  final List<String> dropDownList;
  MyStatefulWidget({Key key, this.dropDownList}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(dropDownList: dropDownList);
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<String> dropDownList;
  _MyStatefulWidgetState({List<String> dropDownList}) : this.dropDownList = dropDownList;
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
        });
      },
      //items: <String>['One', 'Two', 'Free', 'Four']
        items: dropDownList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
