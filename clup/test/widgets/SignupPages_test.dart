import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/CustomerProfile/CustomerSignup.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'ServicesMock.dart';

/*
  TESTS:
    SUCCESSFUL SIGNUP TESTS
    - Successful Customer Signup
    - Successful Store Signup
*/

void main() {
  group("SUCCESSFUL SIGNUP TEST:", () {
    // Successful Customer Signup
    testWidgets('Test Customer Signup', (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_pass", mockUsername: "customer");

      CustomerProfileController customerProfile = CustomerProfileController([
        "username",
        "fname",
        "lname",
        "email",
        "phone",
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: CustomerSignup(
            key: Key("customerSignupPage"),
            services: mock,
            customerProfile: customerProfile,
          ),
        ),
      );

      Finder field = find.byKey(Key("usernameField"));
      await tester.enterText(field, "someuser");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("fnameField"));
      await tester.enterText(field, "firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "1@2.3");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Profile Successfully Created"), findsOneWidget);
    });

    // Successful Store Signup
    testWidgets('Test Store Signup', (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_pass", mockUsername: "store");

      StoreProfileController storeProfile = StoreProfileController([
        "username",
        "store_name",
        "open_time",
        "close_time",
        "capacity",
        "address",
        "city",
        "state",
        "zipcode",
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: StoreSignup(
            key: Key("storeSignupPage"),
            services: mock,
            storeProfile: storeProfile,
          ),
        ),
      );

      Finder field = find.byKey(Key("usernameField"));
      await tester.enterText(field, "someStore");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "TX");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Profile Successfully Created"), findsOneWidget);
    });
  });
}
