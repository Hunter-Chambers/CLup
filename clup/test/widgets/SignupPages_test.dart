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

    FAILED CUSTOMER SIGNUP TESTS
    - Username Too Short
    - Username Too Long
    - Username Has Invalid Character
    - Password Too Short
    - Password Has Invalid Character
    - Password Contains Username
    - Password Check is Mismatched
    - First Name Has Leading Spaces
    - Invalid First Name
    - Last Name Has Leading Spaces
    - Invalid Last Name
    - Invalid Email
    - Invalid Phone
    - Username Already Exists in Database
    - Connection Timed Out
    - Unexpected Error Occurred

    FAILED STORE SIGNUP TESTS
    - Username Too Short
    - Username Too Long
    - Username Has Invalid Character
    - Password Too Short
    - Password Has Invalid Character
    - Password Contains Username
    - Password Check is Mismatched
    - Store Name Has Leading Spaces
    - Store Name Has Invalid Character
    - Invalid Address
    - City Has Leading Spaces
    - Invalid City
    - Invalid State
    - Invalid Zipcode
    - Invalid Open Time
    - Invalid Close Time
    - Invalid Capacity
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
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Profile Successfully Created"), findsOneWidget);
    });
  });

  group("FAILED CUSTOMER SIGNUP TEST:", () {
    testWidgets("Test Customer Too Short of Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "some");

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

      expect(find.text("Must be 5-15 characters"), findsOneWidget);
    });

    testWidgets("Test Customer Too Long of Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "someuser90123456");

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

      expect(find.text("Must be 5-15 characters"), findsOneWidget);
    });

    testWidgets("Test Customer Invalid Character in Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "someuser\\");

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

      expect(find.text("Must not contain \\/%&*()=[]{}\":;.,<>? or spaces"),
          findsOneWidget);
    });

    testWidgets("Test Customer Too Short of Password",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "p");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "p");

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

      expect(find.text("Must be at least 10 characters"), findsOneWidget);
    });

    testWidgets("Test Customer Invalid Character in Password",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "somepassword,");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "somepassword,");

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

      expect(find.text("Must not contain \\/%&*()=[]{}\":;.,<>? or spaces"),
          findsOneWidget);
    });

    testWidgets("Test Customer Password Contains Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "someuser34");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "someuser34");

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

      expect(find.text("Must not contain the username"), findsOneWidget);
    });

    testWidgets("Test Customer Mismatched Password Check",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "possword00");

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

      expect(find.text("Passwords do not match"), findsOneWidget);
    });

    testWidgets("Test Customer First Name Has Leading Spaces",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, " firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "1@2.3");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Please remove all leading spaces"), findsOneWidget);
    });

    testWidgets("Test Customer Invalid First Name",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "!irstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "1@2.3");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Must only contain ' - and letters."), findsOneWidget);
    });

    testWidgets("Test Customer Last Name Has Leading Spaces",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, " lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "1@2.3");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Please remove all leading spaces"), findsOneWidget);
    });

    testWidgets("Test Customer Invalid Last Name", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "!astname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "1@2.3");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Must only contain ' - and letters."), findsOneWidget);
    });

    testWidgets("Test Customer Invalid Email", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "Lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "my_email.com");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Must be a valid email address"), findsOneWidget);
    });

    testWidgets("Test Customer Invalid Phone Number",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "Lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "my_email@place.com");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "L234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Must contain a valid phone number"), findsOneWidget);
    });

    testWidgets("Test Customer Username Already Exists",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "Lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "my_email@place.com");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("That username already exists"), findsOneWidget);
    });

    testWidgets("Test Customer Timed Out", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_timeout", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "Lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "my_email@place.com");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("Connection timed out"), findsOneWidget);
    });

    testWidgets("Test Customer Unexpected Error", (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(
          id: "test_unexpected_error", mockUsername: "customer");

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
      await tester.enterText(field, "Firstname");

      field = find.byKey(Key("lnameField"));
      await tester.enterText(field, "Lastname");

      field = find.byKey(Key("emailField"));
      await tester.enterText(field, "my_email@place.com");

      field = find.byKey(Key("phoneField"));
      await tester.enterText(field, "1234567890");

      await tester.tap(find.byKey(Key("submitBtnCustomer")));
      await tester.pumpAndSettle();

      expect(find.text("An unexpected error occurred"), findsOneWidget);
    });
  });

  group("FAILED STORE SIGNUP TEST:", () {
    testWidgets("Test Store Too Short of Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "stor");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be 5-15 characters"), findsOneWidget);
    });

    testWidgets("Test Store Too Long of Username", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store_34");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be 5-15 characters"), findsOneWidget);
    });

    testWidgets("Test Store Invalid Character in Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store<");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must not contain \\/%&*()=[]{}\":;.,<>? or spaces"),
          findsOneWidget);
    });

    testWidgets("Test Store Too Short of Password",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password0");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password0");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be at least 10 characters"), findsOneWidget);
    });

    testWidgets("Test Store Invalid Character in Password",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password0<");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password0");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must not contain \\/%&*()=[]{}\":;.,<>? or spaces"),
          findsOneWidget);
    });

    testWidgets("Test Store Password Contains Username",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "3_awesome_store_4");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "3_awesome_store_4");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must not contain the username"), findsOneWidget);
    });

    testWidgets("Test Store Mismatched Password Check",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password000");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Passwords do not match"), findsOneWidget);
    });

    testWidgets("Test Store Name Has Leading Spaces",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, " Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Please remove all leading spaces"), findsOneWidget);
    });

    testWidgets("Test Store Invalid Character in Store Name",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "#Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must only contain ' - and letters."), findsOneWidget);
    });

    testWidgets("Test Store Invalid Address", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "m Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be a valid\nstreet address"), findsOneWidget);
    });

    testWidgets("Test Store City Has Leading Spaces",
        (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "   Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Please remove all leading spaces"), findsOneWidget);
    });

    testWidgets("Test Store Invalid City", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

      field = find.byKey(Key("passwordField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("passCheckField"));
      await tester.enterText(field, "password00");

      field = find.byKey(Key("storeNameField"));
      await tester.enterText(field, "Rando Mart");

      field = find.byKey(Key("storeAddressField"));
      await tester.enterText(field, "3 Lancaster Road");

      field = find.byKey(Key("cityField"));
      await tester.enterText(field, "8Amarillo");

      field = find.byKey(Key("stateField"));
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be a valid\ncity name."), findsOneWidget);
    });

    testWidgets("Test Store Invalid State", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

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
      await tester.enterText(field, "99");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be\nin the\nform XX."), findsOneWidget);
    });

    testWidgets("Test Store Invalid Zipcode", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "7912h");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must be a\nvalid zip code."), findsOneWidget);
    });

    testWidgets("Test Store Invalid Open Time", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "o:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Please input as XX:XX\ne.g. 1:00"), findsOneWidget);
    });

    testWidgets("Test Store Invalid Close Time", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "q1:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "1500");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Please input as XX:XX\ne.g. 1:00"), findsOneWidget);
    });

    testWidgets("Test Store Invalid Capacity", (WidgetTester tester) async {
      ServicesMock mock =
          new ServicesMock(id: "test_fail", mockUsername: "store");

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
      await tester.enterText(field, "awesome_store");

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
      await tester.enterText(field, "tx");

      field = find.byKey(Key("zipcodeField"));
      await tester.enterText(field, "79124");

      field = find.byKey(Key("storeOpenField"));
      await tester.enterText(field, "9:00");
      await tester.tap(find.byKey(Key("openAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("openAm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("storeCloseField"));
      await tester.enterText(field, "11:00");
      await tester.tap(find.byKey(Key("closeAmPmBtn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("closePm")));
      await tester.pumpAndSettle();

      field = find.byKey(Key("capacityField"));
      await tester.enterText(field, "00");

      await tester.tap(find.byKey(Key("submitBtnStore")));
      await tester.pumpAndSettle();

      expect(find.text("Must only contain numbers"), findsOneWidget);
    });
  });
}
