// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;

import 'dart:convert';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/StoreProfile/StoreLogin.dart';
import 'package:clup/testing/Services.dart';
import 'package:flutter/material.dart';
//import 'package:dart_code_metrics/metrics_analyzer.dart';
//import 'package:dart_code_metrics/reporters.dart';
import 'package:clup/HomePage.dart';
import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';

void main() {
  runApp(WebApp(
    services: Services(),
  ));
}

class WebApp extends StatelessWidget {
  WebApp({this.services});

  final Services services;

  Future<List<dynamic>> get userOrNone async {
    var csrfTokenOrEmpty = window.localStorage.containsKey("csrf")
        ? window.localStorage["csrf"]
        : "";

    if (csrfTokenOrEmpty != "") {
      var csrfTokenParts = csrfTokenOrEmpty.split(".");

      if (csrfTokenParts.length == 3) {
        var payload = json.decode(
            ascii.decode(base64.decode(base64.normalize(csrfTokenParts[1]))));

        if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
            .isAfter(DateTime.now())) {
          return [
            await services.attemptLoadProfile(csrfTokenOrEmpty),
            payload,
          ];
        }
      }
    }

    return [""];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: userOrNone,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            if (snapshot.data[0] != "failure" && snapshot.data[0] != "") {
              var userInfo = json.decode(snapshot.data[0]);
              var payload = snapshot.data[1];

              if (payload["accType"] == "customer") {
                CustomerProfileController customerController =
                    CustomerProfileController([
                  "username",
                  "fname",
                  "lname",
                  "email",
                  "phone",
                ]);

                customerController.getTextController("username").text =
                    userInfo["username"];
                customerController.getTextController("fname").text =
                    userInfo["fname"];
                customerController.getTextController("lname").text =
                    userInfo["lname"];
                customerController.getTextController("email").text =
                    userInfo["email"];
                customerController.getTextController("phone").text =
                    userInfo["phone"];

                return CustomerLogin(
                  key: Key("customerLoginPage"),
                  jwt: window.localStorage["csrf"],
                  payload: payload,
                  customerController: customerController,
                );
              } else {
                StoreProfileController storeProfile = StoreProfileController([
                  "username",
                  "open_time",
                  "close_time",
                  "capacity",
                  "address",
                  "city",
                  "state",
                  "zipcode",
                ]);

                storeProfile.getTextController("username").text =
                    userInfo["username"];
                storeProfile.getTextController("open_time").text =
                    userInfo["open_time"];
                storeProfile.getTextController("close_time").text =
                    userInfo["close_time"];
                storeProfile.getTextController("capacity").text =
                    userInfo["capacity"];
                storeProfile.getTextController("address").text =
                    userInfo["address"];
                storeProfile.getTextController("city").text = userInfo["city"];
                storeProfile.getTextController("state").text =
                    userInfo["state"];
                storeProfile.getTextController("zipcode").text =
                    userInfo["zipcode"];

                return StoreLogin(
                  key: Key("storeLoginPage"),
                  jwt: window.localStorage["csrf"],
                  payload: payload,
                  storeController: storeProfile,
                );
              }
            }

            window.localStorage.remove("csrf");
            return HomePage(
              key: Key("homePage"),
              title: "CLup Home Page",
              services: services,
            );
          }),
    );
  }
}
