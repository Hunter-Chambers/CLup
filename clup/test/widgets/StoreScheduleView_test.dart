import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/StoreScheduleView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clup/CustomerProfile/QR.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
void main() {

  /* initial setup */
  /* ------------------------------------------------------------------------------- */

  StoreScheduleController storeSchedule = new StoreScheduleController(['Store']);
  storeSchedule.getTextController('Store').text = 'Walmart';

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

  /* ------------------------------------------------------------------------------- */

  testWidgets('Submit button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StoreScheduleView( scheduleController: storeSchedule, customerProfile: customerProfile,
        ),
      ),
    );
    
    // make sure schedule is set
    expect(find.text('Walmart'), findsOneWidget);

    Finder findTiles = find.byKey(Key('timeTile'));
    expect(findTiles, findsNWidgets(36));

    // make sure button is there
    Finder findBtn = find.byKey(Key('subSchedBtn'));
    expect(findBtn, findsOneWidget);

    // tap the button
    await tester.tap(findBtn);
    await tester.pumpAndSettle();

    // Should remain on the same page
    expect(find.text('Walmart'), findsOneWidget);

    // find an available tile
    bool found = false;
    int i = 0;
    Finder tile;
    ListTile timeTile;
    while ( !found ) {
      tile = findTiles.at(i);
      timeTile = tester.firstWidget(tile);

      if ( timeTile.enabled ) {
        found = true;
      }

      else {
        i++;
      }
    }

    if ( !found ) 
      return;

    // tap the tile
    await tester.tap(tile);
    await tester.pumpAndSettle();

    // tile should be selected
    timeTile = tester.firstWidget(tile);
    expect(timeTile.selected, true);
    print(storeSchedule.getSelectedTimes());
    // tap the submit button
    await tester.tap(findBtn);
    await tester.pumpAndSettle();

    
    //expect(find.text('Walmart'), findsOneWidget);
    expect(find.text('To Profile Page'), findsOneWidget);

    // after tapping the button, should be on the QR page
    Finder findQR = find.byKey(Key('QRcode'));
    expect(findQR, findsOneWidget);


  });
}