// *********************************************
// *********************************************
//  NEEDS UPDATING FOR NEW DROP DOWN SETUP
// *********************************************
// *********************************************
import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

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

  testWidgets('Select a state', (WidgetTester tester) async {
    await tester.pumpWidget( 
      MaterialApp(
       home: ScheduleVisit( customerController: customerProfile,)
      )
    );

    // find the drop down of states    
    Finder findDrpDwn = find.byKey(Key('StateDrpDwn'));

    await tester.tap(findDrpDwn);
    /*
    await tester.tap(find.text('Texas'));
    await tester.pumpAndSettle();

    expect(find.text('Texas'), findsOneWidget);

    expect(find.text('Texas'), findsOneWidget);

    */


  });
}