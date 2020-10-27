import 'package:flutter/material.dart';
import 'HomePage.dart';
void main() {
  runApp(WebApp());
}

class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(title: "CLup Home Page"));
  }
}
