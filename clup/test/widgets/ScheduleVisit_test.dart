import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/DisplayTimeSlots.dart';
import 'package:clup/StoreSearch/StoreSearch.dart';
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';

void main() {

  // initialize controller with empty array
  // to skip adding fields, but still initialize time slots
  StoreScheduleController storeSchedule = new StoreScheduleController([]);
  CustomerProfileController customerProfile = new CustomerProfileController([
    "username",
    "fname",
    "lname",
    "email",
    "phone",
  ]);
  customerProfile.getTextController("username")
      .text = 'layton';
  customerProfile.getTextController("fname").text =
      'layton';
  customerProfile.getTextController("lname").text =
      "easterly";
  customerProfile.getTextController("email").text =
      "e.l@gmail.com";
  customerProfile.getTextController("phone").text =
      "1111111111";

  testWidgets('Check text', (WidgetTester tester) async {
    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    // this text should always be there
    expect(find.text('Favorite Stores'), findsOneWidget);
    expect(find.text('- OR -'), findsOneWidget);
    expect(find.text('Select Store'), findsOneWidget);
    expect(find.text('Store Lookup'), findsOneWidget);
    expect(find.text('Choose a Store to Visit'), findsOneWidget);

  });
  testWidgets('Click a tile', (WidgetTester tester) async {
    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    // Get the first listtile from the favorites list
    Finder stores = find.byKey(Key('storeTile'));
    Finder store = stores.first;
    ListTile storeTile = tester.firstWidget(stores.first);

    // get the text field that displays the selected store
    Finder findText = find.byKey(Key('selectedStore'));
    TextField selectedStore = tester.firstWidget(findText);

    // text field should be empty initially
    expect(selectedStore.controller.text, '');

    // click the tile
    await tester.tap(store);
    await tester.pumpAndSettle();

    // get the name of the tile's store
    List<String> titleInfo = storeTile.title.toString().split('\"');
          String titleText = titleInfo[1];
    
    // selectedStore should now display the store of the tapped tile
    expect(selectedStore.controller.text, titleText);

  });


  testWidgets('Select Store button', (WidgetTester tester) async {
    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    // get the select store button
    Finder selStrButton = find.byKey(Key('selStrButton'));

    // tap the button with no store selected
    await tester.tap(selStrButton);
    await tester.pumpAndSettle();

    // should remain on the same page
    expect(find.text('Choose a Store to Visit'), findsOneWidget);

    // add a second walmart
    customerProfile.addvisit('Walmart');

    // get the first Walmart tile
    Finder findTile = find.byKey(Key('storeTile')).first;
    
    // click the Walmart tile
    await tester.tap(findTile);
    await tester.pumpAndSettle();

    // get the text field that displays the selected store
    Finder findText = find.byKey(Key('selectedStore'));
    TextField selectedStore = tester.firstWidget(findText);
    //print(selectedStore.controller.text);


    // tap the button
    await tester.tap(selStrButton);
    await tester.pumpAndSettle();

    // title of next page should be the only widget found
    // if on the same page there are two matching widgets instead of one
    expect(find.text(selectedStore.controller.text), findsOneWidget);

  });


  testWidgets('Store Lookup button', (WidgetTester tester) async {
    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    Finder findText = find.byKey(Key('selectedStore'));
    TextField selectedStore = tester.firstWidget(findText);

    expect(selectedStore.controller.text, '');

    // find the store lookup button
    Finder strLookBtn = find.byKey(Key('strLookBtn'));

    // tap the button
    await tester.tap(strLookBtn);
    await tester.pumpAndSettle();

    expect(find.text('Select a State'), findsOneWidget);

    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    // Get the first listtile from the favorites list
    Finder stores = find.byKey(Key('storeTile'));
    Finder store = stores.first;

    // click the tile
    await tester.tap(store);
    await tester.pumpAndSettle();

    // tap the button
    await tester.tap(strLookBtn);
    await tester.pumpAndSettle();

    expect(find.text('Search for a Store'), findsOneWidget);
    expect(find.text('Choose a Store to Visit'), findsNothing);

  });
}