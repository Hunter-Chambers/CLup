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
    // reset schedule
    storeSchedule.clear();
    storeSchedule.setAlbertsons();
    await tester.pumpWidget( 
      MaterialApp(
        home: Scaffold(
          body: DisplayTimeSlots(scheduleController: storeSchedule,))
        )
      );

    expect(find.byKey(Key('timeTile')), findsNWidgets(40));
  });

  testWidgets('Check labels', (WidgetTester tester) async {
        // reset schedule
        storeSchedule.clear();
        storeSchedule.setAlbertsons();
        await tester.pumpWidget( 
            MaterialApp(
             home: Scaffold(
              body: DisplayTimeSlots(scheduleController: storeSchedule,)))
                    );


        // Make sure all time slots are displayed
        for ( int i = 0; i < 40; i++ ) {
          String time = storeSchedule.timeSlots[i].toString();
          bool available = storeSchedule.timesAvailable[time];

          Finder tiles = find.byKey(Key('timeTile'));
          Finder tile = tiles.at(i);
          ListTile timeTile = tester.firstWidget(tile);

          //print(time);
          //print(timeTile.title.toString());
          List<String> titleInfo = timeTile.title.toString().split('\"');
          String titleText = titleInfo[1];
          //print(label[1]);
          if (available) {
            // make sure tile labeled with time slot correctly
            expect(titleText, time);

            // make sure only one widget displays time slot
            expect(find.text(time), findsOneWidget);
          }
          else {
            // make sure tile labeled 'Full' if unavailable
            expect(titleText, 'Full');
          }
        }
    });

  testWidgets('Select first available tile for Albertsons', (WidgetTester tester) async {
      // reset schedule
      storeSchedule.clear();
      storeSchedule.setAlbertsons();
      await tester.pumpWidget( 
          MaterialApp(
           home: Scaffold(
            body: DisplayTimeSlots(scheduleController: storeSchedule,)))
                  );

        Finder tiles = find.byKey(Key('timeTile'));
        bool found = false;
        int i = 0;
        ListTile timeTile;
        Finder tile;

        // search for first available tile
        while ( !found ) {
          tile = tiles.at(i);
          String time = storeSchedule.timeSlots[i];

          if ( storeSchedule.getAvailable(time) ) {
            // set timeTile to the available tile and stop searching
            timeTile = tester.firstWidget(tile);
            found = true;
          }
          else
            i++;

        }

        // no available tiles
        if ( timeTile == null)
          return;

        // ensure tile is not selected initially
        expect(timeTile.selected, false);

        // initial tile color should not be set
        expect(timeTile.tileColor, null);

        // Check to make sure available time slot
        // tile is enabled
        expect(timeTile.enabled, true); 

        // simulate a tap gesture on the tile
        await tester.tap(tile);
        await tester.pumpAndSettle();

        // make sure tile is selected after the tap
        timeTile = tester.firstWidget(tile);
        expect(timeTile.selected, true);

        // tile should still be enabled
        expect(timeTile.enabled, true);

        // aftter tap, selected time should match first time slot
        expect(storeSchedule.getSelectedTimes(), storeSchedule.timeSlots[i]);

  });

  testWidgets('Select first available tile for Walmart', (WidgetTester tester) async {
        // reset schedule
        storeSchedule.clear();
        storeSchedule.setWalmart();
        await tester.pumpWidget( 
            MaterialApp(
             home: Scaffold(
              body: DisplayTimeSlots(scheduleController: storeSchedule,)))
                    );

        Finder tiles = find.byKey(Key('timeTile'));
        bool found = false;
        int i = 0;
        ListTile timeTile;
        Finder tile;

        // search for first available tile
        while ( !found ) {
          tile = tiles.at(i);
          String time = storeSchedule.timeSlots[i];

          if ( storeSchedule.getAvailable(time) ) {
            // set timeTile to the available tile and stop searching
            timeTile = tester.firstWidget(tile);
            found = true;
          }
          else
            i++;

        }

        // no available tiles
        if ( timeTile == null)
          return;

        // ensure tile is not selected initially
        expect(timeTile.selected, false);

        // initial tile color should not be set
        expect(timeTile.tileColor, null);

        // Check to make sure available time slot
        // tile is enabled
        expect(timeTile.enabled, true); 

        // simulate a tap gesture on the tile
        await tester.tap(tile);
        await tester.pumpAndSettle();

        // make sure tile is selected after the tap
        timeTile = tester.firstWidget(tile);
        expect(timeTile.selected, true);

        // tile should still be enabled
        expect(timeTile.enabled, true);

        // aftter tap, selected time should match time slot
        expect(storeSchedule.getSelectedTimes(), storeSchedule.timeSlots[i]);

        // after tap, tile color should still not be set
        expect(timeTile.tileColor, null);

    });


  testWidgets('Try to select unavailable time slot', (WidgetTester tester) async {
    // reset schedule
    storeSchedule.clear();
    storeSchedule.setWalmart();
    await tester.pumpWidget( 
        MaterialApp(
        home: Scaffold(
          body: DisplayTimeSlots(scheduleController: storeSchedule,)))
                );

   Finder tiles = find.byKey(Key('timeTile'));
   bool found = false;
   int i = 0;
   ListTile timeTile;
   Finder tile;

   // search for first unavailable tile
   while ( !found ) {
     tile = tiles.at(i);
     String time = storeSchedule.timeSlots[i];

     if ( !storeSchedule.getAvailable(time) ) {
       // set timeTile to the available tile and stop searching
       timeTile = tester.firstWidget(tile);
       found = true;
     }
     else
       i++;

   }

   // no unavailable tiles
   if ( timeTile == null)
     return;


   // unavailable tile should not be selected
   expect(timeTile.selected, false);

   // unavailable tile should not be enabled
   expect(timeTile.enabled, false);

   // unavialable tile color should be Colors.grey
   expect(timeTile.tileColor, Colors.grey);

   await tester.tap(tile);
   await tester.pumpAndSettle();

   // unavailable tile should still not be selected
   expect(timeTile.selected, false);

   // unavailble tile should still not be enabled
   expect(timeTile.enabled, false);

   // unavailable tile should still be grey
   expect(timeTile.tileColor, Colors.grey);

   // unavailable tile should not have been added to selected times
   expect(storeSchedule.getSelectedTimes(), '');

  });
  
}
