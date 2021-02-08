// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clup/main.dart';
import 'package:clup/HomePage.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/StoreProfile/StoreLogin.dart';
import 'ServicesMock.dart';

/*
  TESTS:
    - Successful Customer Login
    - Successful Store Login
    - Incorrect Username
    - Incorrect Password
    - Timeout when attemptLogin()
    - Unexpected error when attemptLogin()
    - Unexpected error when attemptLoadProfile()
    - Customer Auto-Login
    - Store Auto-Login
*/

void main() {
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
}
