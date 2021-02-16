import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clup/HomePage.dart';
import 'package:clup/CustomerProfile/CustomerSignup.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'ServicesMock.dart';

/*
  TESTS:
*/

void main() {
  group("SUCCESSFUL SIGNUP TEST:", () {
    // Successful Customer Signup
    testWidgets('Test Customer Signup', (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_pass", mockUsername: "customer");

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      await tester.tap(find.byKey(Key("signUpBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("customerMenuItem")));
      await tester.pumpAndSettle();

      TextFormField field =
          tester.firstWidget(find.byKey(Key("usernameField")));
      field.controller?.text = "someuser";

      field = tester.firstWidget(find.byKey(Key("passwordField")));
      field.controller?.text = "password00";

      field = tester.firstWidget(find.byKey(Key("passCheckField")));
      field.controller?.text = "password00";

      field = tester.firstWidget(find.byKey(Key("fnameField")));
      field.controller?.text = "firstname";

      field = tester.firstWidget(find.byKey(Key("lnameField")));
      field.controller?.text = "lastname";

      field = tester.firstWidget(find.byKey(Key("emailField")));
      field.controller?.text = "1@2.3";

      field = tester.firstWidget(find.byKey(Key("phoneField")));
      field.controller?.text = "1234567890";

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.text("Profile Successfully Created"), findsOneWidget);
    });
  });
}
