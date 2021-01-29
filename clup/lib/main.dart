import 'dart:html' show window;

import 'dart:convert';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:flutter/material.dart';
//import 'package:dart_code_metrics/metrics_analyzer.dart';
//import 'package:dart_code_metrics/reporters.dart';
import 'HomePage.dart';
import 'CustomerProfile/CustomerProfileController.dart';

void main() {
  runApp(WebApp());
}

class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        //window.localStorage.remove("csrf");
        var csrfTokenOrEmpty = window.localStorage.containsKey("csrf")
            ? window.localStorage["csrf"]
            : "";

        if (csrfTokenOrEmpty != "") {
          var str = csrfTokenOrEmpty;
          var token = str.split(".");

          if (token.length != 3) {
            window.localStorage.remove("csrf");
            return HomePage(
              key: Key("homePage"),
              title: "CLup Home Page",
            );
          } else {
            var payload = json.decode(
                ascii.decode(base64.decode(base64.normalize(token[1]))));

            if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                .isAfter(DateTime.now())) {
              CustomerProfileController customerProfile =
                  CustomerProfileController([
                "username",
                "password",
                "fname",
                "lname",
                "email",
                "phone",
              ]);

              customerProfile.getTextController("username").text =
                  payload['username'];
              customerProfile.getTextController("fname").text = "FirstName";
              customerProfile.getTextController("lname").text = "LastName";
              customerProfile.getTextController("email").text =
                  "random@email.com";
              customerProfile.getTextController("phone").text =
                  "(123) 456 - 7890";

              return CustomerLogin(
                key: Key("customerLoginPage"),
                jwt: str,
                payload: payload,
                customerController: customerProfile,
              );
            }

            window.localStorage.remove("csrf");
            return HomePage(
              key: Key("homePage"),
              title: "CLup Home Page",
            );
          }
        }

        window.localStorage.remove("csrf");
        return HomePage(
          key: Key("homePage"),
          title: "CLup Home Page",
        );
      }),
    );
  }
}
