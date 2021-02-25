import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../testing/Services.dart';
//import 'package:flutter/services.dart' show rootBundle;

class SearchStoresController {
  int cityID, storeID;
  Services services;
  Map <String, List<String>> dropDownMenus = new Map<String, List<String>>();
  List<String> labels;
  Map<String, String> selections = new Map<String, String>();

  SearchStoresController(){
    selections['State'] = null;
    selections['City'] = null;
    selections['Store'] = null;
    selections['Address'] = null;

    labels = ['States', 'Cities', 'Stores', 'Addresses'];

  }

  Future<String> getMenuItems( String menu) async{
    return await rootBundle.loadString("$menu.json");
  }

  setCityID(int id){
    cityID = id;
  }
  
  int getCityID() {
    return cityID;
  }

  setStoreID(int id){
    storeID = id;
  }

  int getStoreID() {
    return storeID;
  }


  setMenuItems( String menu, List<String> menuItems ){
    dropDownMenus[menu] = menuItems;
  }

  setSelection(String dropDown, String selection){
    selections[dropDown] = selection;
  }

  String getSelection(String dropDown){
    return( selections[dropDown] );
  }

  whichState(String label) {
    String key = getSelection(label);

    switch (key) {
      case 'Oklahoma': {
        dropDownMenus['Cities'] = ['Norman', 'Stillwater', 'Oklahoma City'];
      }
      break;
      case 'New Mexico': {
        dropDownMenus['Cities'] = ['Albuquerque', 'Santa Fe', 'Angel Fire'];
      }
      break;
    }
    return null;

  }

  whichSelection(String label) {
    String key = getSelection(label);

    switch (label) {
      case 'States': {
        switch (key){
          case 'Texas':{
          dropDownMenus['Cities'] = ['Amarillo', 'Lubbock', 'Dallas'];
          }
          break;
          case 'Oklahoma': {
           dropDownMenus['Cities'] = ['Norman', 'Stillwater', 'Oklahoma City'];
          }
          break;
          case 'New Mexico': {
           dropDownMenus['Cities'] = ['Albuquerque', 'Santa Fe', 'Angel Fire'];
          }
          break;   }
        }
      break;
      case 'Cities': {
        
      }
      break;
      case 'Stores': {

      }
      break;
      case 'Addresses': {

      }
      break;
    }
  }

}