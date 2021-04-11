import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SearchStoresController.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import '../CustomerProfile/CustomerProfileController.dart';

// ================================================================
/* This view displays 4 dynamic, dependent dropdown boxes
   that display store location information starting from the
   state -> city -> store -> address. Once all 4 dropdowns have
   a selected value, the user may click on the 'Add to favorites'
   button to add the store to their list of favorites saved in 
   his/her profile. A second button allows the user to travel back
   to his/her profile page. The user may add 0 to many stores.' */
// ====================================================================

class StoreSearch extends StatelessWidget {
  //final String _title = 'Select a State';
  //final String _label = 'States';

  final CustomerProfileController customerProfile;
  final SearchStoresController menuItems = SearchStoresController();
  StoreSearch ({Key key, CustomerProfileController customerController}) : this.customerProfile = customerController, super(key: key);

  Widget build(BuildContext context) {
    return 
    MaterialApp(
      home: MyStatesView(searchController: menuItems, customerController: customerProfile,),
    );}
}

class MyStatesView extends StatefulWidget{
  final SearchStoresController menuItems;
  final CustomerProfileController customerProfile;
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
  void initState() {
    _setStatesList();
    super.initState();
  }
  // lists to display dropdown items
  List _statesList, _citiesList, _storesList, _addressesList;

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
                              _citiesChanged = true;
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
                              _storesChanged = true;
                              _storesValue = newValue;
                              menuItems.setSelection(menuItems.labels[2], _storesValue);
                              _setNextDropDown(2);
                            });
                          },
                          items: _displayMenu(2),
                        ),
                      ),

                      /* ================================================================= Addresses Drop Down */

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
                          items:  _displayMenu(3),
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
                  // ================================================== Add to favorites button
                  Container(
                    padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "StateBtn",
                      onPressed: () => _onButtonPressed(context, 1),
                      label: Text(
                        "Add to favorites",
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

                  // ================================================== Return to profile page button
              Container(
                padding: EdgeInsets.fromLTRB(300,20,300,0),
                child: FloatingActionButton.extended(
                  onPressed:() => _onButtonPressed(context, 2), 
                  heroTag: 'strToProfBtn',
                  label: Text('Return to Profile Page'),
                  )
              ),
              /*
              Container(
                padding: EdgeInsets.fromLTRB(300,20,300,0),
                child: FloatingActionButton.extended(
                  onPressed:() => _onButtonPressed(context, 3), 
                  heroTag: 'testBtn',
                  label: Text('Add entry to the json'),
                  )
              ),
              */

              Container(
                padding: EdgeInsets.fromLTRB(50, 35, 50, 52),
              ),
            ],
          ),
        ),
      ),
    );
   }


  // helper function to determine which list is displayed
  // in the dropdown
  List<DropdownMenuItem<String>> _displayMenu(int i){
    List<dynamic> items;
    switch (i) {
      case 0: {
        items = _statesList;
      }
      break;

      case 1: {
        items = _citiesList;
      }
      break;

      case 2: {
        items = _storesList;
      }
      break;

      case 3: {
        items = _addressesList;
      }
      break;
    }

    return menuItems.convertMenu(items);
    
   }
    
  // When the user has added a store to his/her favorites
  // this function is called to reset all dropdowns back
  // to default values
  _reset(){

    _statesValue = null;
    _statesList = null;
    menuItems.setSelection(menuItems.labels[0], null);
      
    _citiesValue = null;
    _citiesList = null;
    menuItems.setSelection(menuItems.labels[1], null);

    _storesValue = null;
    _storesList = null;
    menuItems.setSelection(menuItems.labels[2], null);
    
    _addressesValue = null;
    _addressesList = null;
    menuItems.setSelection(menuItems.labels[3], null);

    _setStatesList();

  }

  // When a user selects a value from a dropbox,
  // this function controls the 'dependency' of all
  // the following drop boxes
  
  _setNextDropDown(int i) async{
    String dropDown = menuItems.labels[i];
    String selection = menuItems.getSelection(dropDown);
    setState(() {
      if ( _statesChanged ) {
        _citiesValue = null;
        _citiesList = null;
        menuItems.setSelection(menuItems.labels[1], null);

        _storesValue = null;
        _storesList = null;
        menuItems.setSelection(menuItems.labels[2], null);
        
        _addressesValue = null;
        _addressesList = null;
        menuItems.setSelection(menuItems.labels[3], null);

        _statesChanged = false;

        _setCitiesList(selection);
      }
      else if ( _citiesChanged ) {
        _storesValue = null;
        _storesList = null;
        menuItems.setSelection(menuItems.labels[2], null);
        
        _addressesValue = null;
        _addressesList = null;
        menuItems.setSelection(menuItems.labels[3], null);

        _citiesChanged = false;

        _setStoresList(selection);
      }
      else if ( _storesChanged ) {
        _addressesValue = null;
        _addressesList = null;
        menuItems.setSelection(menuItems.labels[3], null);

        _storesChanged = false;

        _setAddressesList(selection);
      }
    });
  }

  // a helper function to set the _statesList of the states
  // dropdown and trigger a setstate() for the parent widget 
  _setStatesList() async {

    List tempList = await menuItems.getMenuItems("States.json", "states", "false");
    
    setState(() {
      _statesList = tempList;
    });

  }


  // a helper function to set the _citiesList of the cities
  // dropdown and trigger a setstate() for the parent widget 
  _setCitiesList(String selection) async {
    List tempList = await menuItems.getMenuItems("Cities.json", selection, "true");

    int id = int.parse(tempList[tempList.length - 1]);
    tempList = tempList.sublist(0, tempList.length - 1);
    menuItems.setCityID(id);

    setState(() {
      _citiesList = tempList;
    });

  }


  // a helper function to set the _storesList of the stores
  // dropdown and trigger a setstate() for the parent widget 
  _setStoresList(String selection) async {
    int cityID = menuItems.getCityID();
    String key = selection+'-$cityID';
    List tempList = await menuItems.getMenuItems("Stores.json", key, "true");

    int id = int.parse(tempList[tempList.length - 1]);
    tempList = tempList.sublist(0, tempList.length - 1);
    menuItems.setStoreID(id);

    setState(() {
      _storesList = tempList;
    });

  }

  // a helper function to set the _addressesList of the addresses
  // dropdown and trigger a setstate() for the parent widget 
  _setAddressesList(String selection) async {
    int storeID = menuItems.getStoreID();
    String key = selection+'-$storeID';
    List tempList = await menuItems.getMenuItems("Addresses.json", key, "false");

    setState(() {
      _addressesList = tempList;
    });

  }


  // helper function that controls what happens
  // when either button is pressed
  _onButtonPressed(BuildContext context, int option) {

    // the 'Add to favorites' button was pressed
    switch (option) {
      case 1: {

        String storeInfo = menuItems.buildStoreInfo();

        // if one or more fields were not selected,
        // prompt the user 
        if ( storeInfo == '' ) {
          Fluttertoast.showToast(
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            msg: 'One or more fields not selected.',
            webPosition: 'center',
            );

        }
        // all fields were selected,
        // add the store info to user's favorites.
        // Prompt the user store was added
        else {
          customerProfile.addFavoriteStore(storeInfo);
          print(storeInfo);

          String msg = storeInfo + ' was added to Favorites';
    
          final snackBar = SnackBar(content: Text(msg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          _reset();
        }
      }
      break;

      // 'Return to Profile Page' button was pressed
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
