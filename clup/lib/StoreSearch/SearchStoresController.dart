class SearchStoresController {
  Map <String, List<String>> dropDownMenus = new Map<String, List<String>>();
  String label;
  Map<String, String> selections = new Map<String, String>();

  SearchStoresController(){
    selections['State'] = '';
    selections['City'] = '';
    selections['Store'] = '';
    selections['Address'] = '';

    label = '';

    dropDownMenus['States'] = ['Texas', 'Oklahoma', 'New Mexico'];
    dropDownMenus['Cities'] = ['Amarillo', 'Lubbock', 'Dallas'];
    dropDownMenus['Stores'] = ['Walmart', 'HEB', 'United Supermarkets'];
    dropDownMenus['Addresses'] = ['111 SomeLane', '222 SomeRoad', '333 SomeStreet'];

  }

  List<String> getMenuItems( String menu ) {
    return dropDownMenus[menu];
  }

  setMenuItems( String menu, List<String> menuItems ){
    dropDownMenus[menu] = menuItems;
  }

  setLabel( String newLabel ) {
    label = newLabel;
  }

  setSelection(String dropDown, String selection){
    selections[dropDown] = selection;
  }

  String getSelection(String dropDown){
    return( selections[dropDown] );
  }

  whichState() {
    String key = getSelection('State');

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

}