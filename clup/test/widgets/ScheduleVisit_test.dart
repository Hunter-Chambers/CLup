import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/Schedule/DisplayTimeSlots.dart';
import 'package:clup/StoreSearch/StatesView.dart';
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

    expect(find.text('Favorite Stores'), findsOneWidget);
    expect(find.text('- OR -'), findsOneWidget);
    expect(find.text('Select Store'), findsOneWidget);
    expect(find.text('Store Lookup'), findsOneWidget);
    expect(find.text('Choose a Store to Visit'), findsOneWidget);


  });

}