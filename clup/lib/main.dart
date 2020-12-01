import 'package:flutter/material.dart';
//import 'package:dart_code_metrics/metrics_analyzer.dart';
//import 'package:dart_code_metrics/reporters.dart';
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
