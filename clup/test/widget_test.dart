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

void main() {
  testWidgets('Homepage Login Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(title: "CLup Home Page"),
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
    expect(find.text("Customer Profile Page"), findsNothing);

    await tester.tap(loginBtnFinder);
    await tester.pumpAndSettle();

    expect(find.text("Customer Profile Page"), findsOneWidget);
  });
}
