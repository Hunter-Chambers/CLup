// ignore: avoid_web_libraries_in_flutter
@TestOn('chrome')
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clup/main.dart';
import 'package:clup/HomePage.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/StoreProfile/StoreLogin.dart';
import 'package:clup/CustomerProfile/CustomerSignup.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'ServicesMock.dart';

/*
  TESTS:
    LOGIN TESTS
    - Successful Customer Login
    - Successful Store Login
    - Incorrect Username
    - Incorrect Password
    - Timeout when attemptLogin()
    - Unexpected error when attemptLogin()
    - Unexpected error when attemptLoadProfile()
    - Customer Auto-Login
    - Store Auto-Login

    NAVIGATION TESTS
    - Successful Nav To Customer Sign-Up
    - Successful Nav To Store Sign-Up
*/

void main() {
  group("LOGIN TEST:", () {
    // Successful Customer Login
    testWidgets('Test Correct Customer Login', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock();

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "customer";
      passFieldWidget.controller?.text = "password00";

      expect(loginBtnFinder, findsOneWidget);
      expect(find.byType(CustomerLogin), findsNothing);

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.byType(CustomerLogin), findsOneWidget);
    });

    // Successful Store Login
    testWidgets('Test Correct Store Login', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock();

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "store";
      passFieldWidget.controller?.text = "password00";

      expect(loginBtnFinder, findsOneWidget);
      expect(find.byType(CustomerLogin), findsNothing);

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.byType(StoreLogin), findsOneWidget);
    });

    // Incorrect username
    testWidgets('Test Incorrect Username', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock();

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "wronguser";
      passFieldWidget.controller?.text = "password00";

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text("Username or Password is incorrect"), findsOneWidget);
    });

    // Incorrect password
    testWidgets('Test Incorrect Password', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock();

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "customer";
      passFieldWidget.controller?.text = "wrongpass";

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text("Username or Password is incorrect"), findsOneWidget);
    });

    // Timeout when attemptLogin()
    testWidgets('Test Timeout Error Login', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(id: "test_timeout");

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "customer";
      passFieldWidget.controller?.text = "password00";

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text("Connection timed out"), findsOneWidget);
    });

    // Unexpected error when attemptLogin()
    testWidgets('Test Unexpected Error Login', (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(id: "test_unexpected_error");

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "customer";
      passFieldWidget.controller?.text = "password00";

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text("Login Failed"), findsOneWidget);
      expect(find.text("An unexpected error occurred"), findsOneWidget);
    });

    // Unexpected error when attemptLoadProfile()
    testWidgets('Test Unexpected Error Loading Profile',
        (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(failLoadProfile: true);

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: Key("homePage"),
            title: "CLup Home Page",
            services: mock,
          ),
        ),
      );

      final TextField userFieldWidget =
          tester.firstWidget(find.byKey(Key("userField")));
      final TextField passFieldWidget =
          tester.firstWidget(find.byKey(Key("passField")));

      userFieldWidget.controller?.text = "customer";
      passFieldWidget.controller?.text = "password00";

      final Finder loginBtnFinder =
          find.widgetWithText(FloatingActionButton, "Login");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text("Loading Profile Failed"), findsOneWidget);
      expect(find.text("An unexpected error occurred"), findsOneWidget);
    });

    // Customer Auto-Login
    testWidgets("Test Customer Auto-Login", (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(mockUsername: "customer");

      window.localStorage["csrf"] =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImN1c3RvbWVyIiwiYWNjVHlwZSI6ImN1c3RvbWVyIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTM0Mzc4NzN9.r05bFhutGXFRsjk0coYNWVo8ce0wOZhqdVNZw05rCtM";

      await tester.pumpWidget(
        MaterialApp(
          home: WebApp(
            services: mock,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomerLogin), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
    });

    // Store Auto-Login
    testWidgets("Test Store Auto-Login", (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(mockUsername: "store");

      window.localStorage["csrf"] =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InN0b3JlIiwiYWNjVHlwZSI6InN0b3JlIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTM0Mzg4MTR9.zmZudeOtuYvyjfCdMj3iRuhOG6uFETkpLeqwVwT8x9o";

      await tester.pumpWidget(
        MaterialApp(
          home: WebApp(
            services: mock,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StoreLogin), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
    });
  });

  group("NAVIGATION TEST:", () {
    testWidgets("Test Nav to Customer Sign-Up", (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(mockUsername: "customer");

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

      expect(find.byType(CustomerSignup), findsOneWidget);
    });

    testWidgets("Test Nav to Store Sign-Up", (WidgetTester tester) async {
      ServicesMock mock = new ServicesMock(mockUsername: "store");

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
      await tester.tap(find.byKey(Key("storeMenuItem")));
      await tester.pumpAndSettle();

      expect(find.byType(StoreSignup), findsOneWidget);
    });
  });
}
