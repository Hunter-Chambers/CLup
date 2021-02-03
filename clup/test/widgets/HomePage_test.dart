// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clup/main.dart';
import 'package:clup/HomePage.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/StoreProfile/StoreLogin.dart';

void main() {
  // Make sure to connect to server first
  testWidgets('Test Correct Customer Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        //home: WebApp(
        home: HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
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

    await tester.runAsync(() async {
      await tester.tap(loginBtnFinder);
      await Future.delayed(Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    expect(find.byType(CustomerLogin), findsOneWidget);
  });

  // Make sure to disconnect from server first
  testWidgets('Test Timeout Error Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
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

    await tester.runAsync(() async {
      await tester.tap(loginBtnFinder);
      await Future.delayed(Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    expect(find.text("Connection timed out"), findsOneWidget);
  });

  // Make sure to add a throw statement to Services.attemptLogin()
  testWidgets('Test Unexpected Error Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
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

    await tester.runAsync(() async {
      await tester.tap(loginBtnFinder);
      await Future.delayed(Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    expect(find.text("Login Failed"), findsOneWidget);
    expect(find.text("An unexpected error occurred"), findsOneWidget);
  });

  // Make sure to connect to server first
  // Make sure to add a throw statement to Services.attemptLoadProfile()
  testWidgets('Test Unexpected Error Loading Profile',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
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

    await tester.runAsync(() async {
      await tester.tap(loginBtnFinder);
      await Future.delayed(Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    expect(find.text("Loading Profile Failed"), findsOneWidget);
    expect(find.text("An unexpected error occurred"), findsOneWidget);
  });
}
