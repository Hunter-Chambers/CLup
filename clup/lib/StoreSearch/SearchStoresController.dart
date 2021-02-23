class SearchStoresController {
  Map <String, List<String>> dropDownMenus = new Map<String, List<String>>();
  List<String> labels;
  Map<String, String> selections = new Map<String, String>();

  SearchStoresController(){
    selections['State'] = '';
    selections['City'] = '';
    selections['Store'] = '';
    selections['Address'] = '';

    labels = ['States', 'Cities', 'Stores', 'Addresses'];

    dropDownMenus['States'] = ['Texas', 'Oklahoma', 'New Mexico'];
    //dropDownMenus['Cities'] = ['Amarillo', 'Lubbock', 'Dallas'];
    //dropDownMenus['Stores'] = ['Walmart', 'HEB', 'United Supermarkets'];
    //dropDownMenus['Addresses'] = ['111 SomeLane', '222 SomeRoad', '333 SomeStreet'];

  }

  List<String> getMenuItems( String menu ) {
    return dropDownMenus[menu];
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