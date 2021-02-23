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

  // Drop Down values
  String _statesValue, _citiesValue, _storesValue, _addressesValue;

  // Drop Down flags
  bool _statesChanged = false, _citiesChanged = false, _storesChanged = false;

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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 50),
                      shrinkWrap: true,
                      children: [


                      /* ================================================================= States Drop Down */
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child:
                        DropdownButton<String>(
                          key: Key('StateDrpDwn'),
                          hint: Text(menuItems.labels[0]),
                          value: _statesValue,
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
                              _statesChanged = true;
                              _statesValue = newValue;
                              menuItems.setSelection(menuItems.labels[0], _statesValue);
                              _setNextDropDown(0);
                            });
                          },
                          items: _displayMenu(0),
                        )   ,
                      ), 
                       

                      /* ================================================================= Cities Drop Down */

                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: 
                        DropdownButton<String>(
                          key: Key('CityDrpDwn'),
                          hint: Text(menuItems.labels[1]),
                          value: _citiesValue,
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
                              _citiesValue = newValue;
                              menuItems.setSelection(menuItems.labels[1], _citiesValue);
                              _setNextDropDown(1);
                            });
                          },
                          items: _displayMenu(1),
                        ),
                      ), 

                       

                      /* ================================================================= Stores Drop Down */

                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child:
                        DropdownButton<String>(
                          key: Key('StoreDrpDwn'),
                          hint: Text(menuItems.labels[2]),
                          value: _storesValue,
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
                              _storesValue = newValue;
                              menuItems.setSelection(menuItems.labels[2], _storesValue);
                              _setNextDropDown(2);
                            });
                          },
                          items: _displayMenu(2),
                        ),
                      ),

                      /* ================================================================= Stores Drop Down */

                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child:
                        DropdownButton<String>(
                          key: Key('AddressDrpDwn'),
                          hint: Text(menuItems.labels[3]),
                          value: _addressesValue,
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
                              _addressesValue = newValue;
                              menuItems.setSelection(menuItems.labels[3], _addressesValue);
                              _setNextDropDown(3);
                            });
                          },
                          items: _displayMenu(3),
                        ),
                      ),
                       
                      ],
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

  List<DropdownMenuItem<String>> _displayMenu(int i){
    List<String> items = menuItems.getMenuItems(menuItems.labels[i]);
    return (
         items?.map<DropdownMenuItem<String>>((String value) {
           return new DropdownMenuItem<String>(
             value: value,
             child: new Text(value),
         );
       })?.toList() ?? []
     );
   }


  _setNextDropDown(int i) {
    setState(() {
      if ( _statesChanged ) {
        _citiesValue = null;
        _storesValue = null;
        _addressesValue = null;
        _statesChanged = false;
      }
      else if ( _citiesChanged ) {
        _storesValue = null;
        _addressesValue = null;
        _citiesChanged = false;
      }
      else if ( _storesChanged ) {
        _addressesValue = null;
        _storesChanged = false;
      }
          menuItems.whichSelection(menuItems.labels[i]);
    });
 
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