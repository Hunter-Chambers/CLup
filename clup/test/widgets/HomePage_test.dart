// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clup/HomePage.dart';
import 'package:clup/StoreProfile/StoreLogin.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Successful Customer Login Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(key: Key("homePage"), title: "CLup Home Page"),
      ),
    );

    final Finder loginBtnFinder =
        find.widgetWithText(FloatingActionButton, "Login");

    final TextField userFieldWidget =
        tester.firstWidget(find.byKey(Key("userField")));
    final TextField passFieldWidget =
        tester.firstWidget(find.byKey(Key("passField")));

    userFieldWidget.controller.text = "customer";
    passFieldWidget.controller.text = "password00";

    expect(loginBtnFinder, findsOneWidget);
    expect(find.byKey(Key("customerLoginPage")), findsNothing);

    await tester.tap(loginBtnFinder);
    await tester.pumpAndSettle();

    expect(find.byKey(Key("customerLoginPage")), findsOneWidget);
  });

  testWidgets('Failed Login Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
        ),
      ),
    );
  });

  testWidgets('Sample Test', (WidgetTester tester) async {
    StoreProfileController temp = StoreProfileController([
      "username",
      "password",
      "open_time",
      "close_time",
      "capacity",
      "address",
      "city",
      "state",
      "zipcode",
    ]);

    temp.getTextController("username").text = "store";
    temp.getTextController("password").text = "password00";
    temp.getTextController("open_time").text = "7:00AM";
    temp.getTextController("close_time").text = "11:00PM";
    temp.getTextController("capacity").text = "1500";
    temp.getTextController("address").text = "1234 Random Street";
    temp.getTextController("city").text = "Amarillo";
    temp.getTextController("state").text = "TX";
    temp.getTextController("zipcode").text = "79124";

    await tester.pumpWidget(
      MaterialApp(
        home: StoreLogin(
          key: Key("storeLoginPage"),
          storeController: temp,
        ),
      ),
    );
  });
}
