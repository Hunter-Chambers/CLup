import 'package:flutter/material.dart';
import '../Services/Services.dart';

class SearchStoresController {
  int _cityID, _storeID;
  Services services;
  Map <String, List<String>> dropDownMenus;
  List<String> labels;
  Map<String, String> selections;

  SearchStoresController(){
    selections = new Map<String, String>();
    selections['State'] = null;
    selections['City'] = null;
    selections['Store'] = null;
    selections['Address'] = null;

    labels = ['States', 'Cities', 'Stores', 'Addresses'];

    dropDownMenus = new Map<String, List<String>>();
  }

  // pulls dropdown infromation from specified json file
  Future<List<String>> getMenuItems( String fileName, String menu, String needID) async{

    String temp = await Services.getMenuItems(fileName, menu, needID);
    List tempList = temp.split(",");

    for ( int i=0; i < tempList.length; i++) {
      tempList[i] = tempList[i].replaceFirst(' u', "");
      tempList[i] = tempList[i].replaceAll('\[', "");
      tempList[i] = tempList[i].replaceAll('\]', "");
      tempList[i] = tempList[i].replaceAll('\'', "");
      tempList[i] = tempList[i].replaceAll('\n', "");
    }
    tempList[0] = tempList[0].replaceFirst('u', "");


    return tempList;

  }
  

  // ========================================= id handling
  setCityID(int id){
    _cityID = id;
  }
  
  int getCityID() {
    return _cityID;
  }

  setStoreID(int id){
    _storeID = id;
  }

  int getStoreID() {
    return _storeID;
  }
  // =====================================================


  // ===================================================== selection handling 
  setSelection(String dropDown, String selection){
    selections[dropDown] = selection;
  }

  String getSelection(String dropDown){
    return( selections[dropDown] );
  }
  // =========================================================

  // converts a list to do be displayable by a dropdown
  List<DropdownMenuItem<String>> convertMenu(List<dynamic> items){
    
    return (
         items?.map<DropdownMenuItem<String>>((dynamic value) {
           return new DropdownMenuItem<String>(
             value: value,
             child: new Text(value),
         );
       })?.toList() ?? []
     );
   }
    
  // concatenate all the store info into one string
  String buildStoreInfo() {

    String state = getSelection(labels[0]);
    String city = getSelection(labels[1]);
    String store = getSelection(labels[2]);
    String address = getSelection(labels[3]);

    // check to make sure all fields were selected
    // if not, return an empty string
    if (address == null || store == null || city == null || state == null ) {

      return '';
    }

    // otherwise concatenate and return store info
    else {

      String storeSelection = store + ',' +
        address + ',' + city + ',' +  state;

      return storeSelection;

    }
  }

}