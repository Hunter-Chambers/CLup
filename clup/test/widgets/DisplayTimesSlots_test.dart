import 'package:clup/Schedule/DisplayTimeSlots.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';

void main() {

  // initialize controller with empty array
  // to skip adding fields, but still initialize time slots
  StoreScheduleController storeSchedule = new StoreScheduleController([]);

  // set the store schedule to sample schedule 'Walmart'
  // and make sure correct number of tiles generated
  testWidgets('Correct number of tiles for Walmart', (WidgetTester tester) async {
    storeSchedule.setWalmart();
    await tester.pumpWidget( 
      MaterialApp(
       home: Scaffold(
        body: DisplayTimeSlots(scheduleController: storeSchedule,))
      )
    );

    expect(find.byKey(Key('timeTile')), findsNWidgets(36));
  });


  // set the store schedule to sample schedule 'Albertsons'
  // and make sure correct number of tiles generated
  testWidgets('Correct number of tiles for Alberstons', (WidgetTester tester) async {
    storeSchedule.setAlbertsons();
    await tester.pumpWidget( 
      MaterialApp(
        home: Scaffold(
          body: DisplayTimeSlots(scheduleController: storeSchedule,))
        )
      );

      expect(find.byKey(Key('timeTile')), findsNWidgets(40));
  });

  testWidgets('Select a tile', (WidgetTester tester) async {
      storeSchedule.setAlbertsons();
      await tester.pumpWidget( 
          MaterialApp(
           home: Scaffold(
            body: DisplayTimeSlots(scheduleController: storeSchedule,))
          )
        );

        Finder tiles = find.byKey(Key('timeTile'));
        Finder tile = tiles.first;
        ListTile timeTile = tester.firstWidget(tile);

        // ensure tile is not selected initially
        expect(timeTile.selected, false);

        expect(timeTile.tileColor, null);

        // simulate a tap gesture on the tile
        await tester.tap(tile);
        await tester.pumpAndSettle();

        // make sure tile is selected after the tap
        timeTile = tester.firstWidget(tile);
        expect(timeTile.selected, true);


  });

}
