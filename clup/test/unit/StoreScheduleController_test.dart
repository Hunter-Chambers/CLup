import 'package:clup/Schedule/StoreScheduleController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

StoreScheduleController storeSchedule;
setup( List<String> fields ){
  storeSchedule = new StoreScheduleController(fields);
}

teardown(){

  storeSchedule = null;

}

void main() {

  // test constructor with no given fields
  test("Initialize with empty", () {
    setup([]);

    // all atributes should initialize as empty
    expect(storeSchedule.fieldsMap.length, 0);
    expect(storeSchedule.fieldsMap, {});

    expect(storeSchedule.timeSlots.length, 0);
    expect(storeSchedule.timeSlots, []);

    expect(storeSchedule.timesAvailable.length, 0);
    expect(storeSchedule.timesAvailable, {});

    expect(storeSchedule.selectedTimes.length, 0);
    expect(storeSchedule.selectedTimes, {});

    teardown();
  });

  // test constructor with given fields
  test("Initialize with fields", () {
    List<String> fields = ['field1', 'field2', 'field3'];
    setup(fields);
    // fieldsMap attribute should have length 3
    expect(storeSchedule.fieldsMap.length, 3);

    // fieldsMap attribute should have the key value pairs:
    // field1:TextEditingController(), field2:TextEditingController(), field3:TextEditingController()
    for (String field in fields) {
      expect(storeSchedule.fieldsMap[field].runtimeType, TextEditingController);
    }


    // all other attributes should be empty
    expect(storeSchedule.timeSlots.length, 0);
    expect(storeSchedule.timeSlots, []);

    expect(storeSchedule.timesAvailable.length, 0);
    expect(storeSchedule.timesAvailable, {});

    expect(storeSchedule.selectedTimes.length, 0);
    expect(storeSchedule.selectedTimes, {});

    teardown();

  });


  test("Testing clear()", () {
    List<String> fields = ['field1', 'field2', 'field3'];
    setup(fields);

    storeSchedule.setAlbertsons();
    String time = storeSchedule.timeSlots[0];
    storeSchedule.updateSelectedTimes(0, time);

    // make sure attributes set initally
    expect(storeSchedule.timeSlots.length, 40);
    expect(storeSchedule.timesAvailable.length, 40);
    expect(storeSchedule.getSelectedTimes(), time);
    expect(storeSchedule.fieldsMap[fields[0]].runtimeType, TextEditingController);

    // clear out the schedule
    storeSchedule.clear();

    // attributes should all be empty again
    expect(storeSchedule.timeSlots.length, 0);
    expect(storeSchedule.timesAvailable.length, 0);
    expect(storeSchedule.getSelectedTimes(), '');
    expect(storeSchedule.fieldsMap.length, 0);


    teardown();
  });


  test('Get text editing controller', () {
    List<String> fields = ['field1', 'field2', 'field3'];
    setup(fields);

    // check to see if return is a text editing controller for all fields
    for ( String field in fields ) {
      expect(storeSchedule.getTextController(field).runtimeType, TextEditingController);
    }

    teardown();
  });

  test('Get available ', () {
    setup([]);
    storeSchedule.setAlbertsons();

    // first time slot should be available
    expect(storeSchedule.getAvailable(storeSchedule.timeSlots[0]), true);

    // second time slot should not be available
    expect(storeSchedule.getAvailable(storeSchedule.timeSlots[1]), false);

    teardown();

  });


  // this test does not look at whether or not the tile is available
  test('Update selected times', () {

    setup([]);
    storeSchedule.setHEB();

    /* add first selected time */
    int i = 0;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect( storeSchedule.selectedTimes[0], storeSchedule.timeSlots[i] );


    /* remove first selected time */
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect( storeSchedule.selectedTimes[0], null);


    /* add two consecutive items */
    i = 0;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect( storeSchedule.selectedTimes[0], storeSchedule.timeSlots[i] );
    i = 1;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect( storeSchedule.selectedTimes[1], storeSchedule.timeSlots[i] );


    /* add a nonconsecutive item */
    i = 4;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), false); 
    expect(storeSchedule.selectedTimes.length, 2);
    
    /* remove an item on the end */
    i = 2;
    // add an item onto the end
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 3);

    // indices are now 0, 1, 2.
    // remove the item on the end, 2
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 2);

    // re add the item
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 3);

    // indices are now 0, 1, 2.
    // remove the item on the other end, 0
    i = 0;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 2);
    

    /* remove an item not on the end */
    i = 0;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 3);

    i = 3;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
    expect(storeSchedule.selectedTimes.length, 4);

    // indices are now 0, 1, 2, 3
    // therfore internal items are at indices 1 and 2
    // attempt to remove at index 1 should not update
    i = 1;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), false);
    expect(storeSchedule.selectedTimes.length, 4);

    // attempt to remove at index 2 should also not update
    i = 2;
    expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), false);
    expect(storeSchedule.selectedTimes.length, 4);

    teardown();
  });


  test('Get selected times', () {
    setup([]);
    storeSchedule.setUnited();

    /* test on empty */
    expect(storeSchedule.getSelectedTimes(), '');

    /* selected times in ascending order */
    // set up selected times map in ascending order
    for ( int i = 0; i < 10; i++ ) {
      expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
      expect(storeSchedule.selectedTimes.length, i+1);
    }

    expect(storeSchedule.getSelectedTimes(), '8:00 - 10:30');

    // set up selected times map in desceding order
    storeSchedule.clear();
    setup([]);
    storeSchedule.setUnited();
    int j = 0;
    for ( int i = 9; i >= 0; i-- ) {
      expect(storeSchedule.updateSelectedTimes(i, storeSchedule.timeSlots[i]), true);
      expect(storeSchedule.selectedTimes.length, ++j);
    }

    expect(storeSchedule.getSelectedTimes(), '8:00 - 10:30');
  });


}
