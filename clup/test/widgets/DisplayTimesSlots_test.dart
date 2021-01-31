import 'package:clup/Schedule/DisplayTimeSlots.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';

void main() {

  // initialize controller with empty array
  // to skip adding fields, but still initialize time slots
  StoreScheduleController storeSchedule = new StoreScheduleController([]);

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
        expect(timeTile.selected, false);

        //await tester.pump(Duration(seconds: 10));
        await tester.tap(tile);
        await tester.pumpAndSettle();

        timeTile = tester.firstWidget(tile);

        //print('tiles.first: ' + tiles.first.toString());
        //print('timeTile: ' + timeTile.toString());

        print('---------------');
        print(timeTile.selected);
        expect(timeTile.selected, true);


  });

}
