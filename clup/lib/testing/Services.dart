// ignore: avoid_web_libraries_in_flutter
import 'dart:io';
import 'dart:html' show window;

import 'dart:async';
import 'package:clup/CustomerProfile/CustomerSignup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Services {
  static const ROOT = "http://10.0.6.1/cs4391/hc998658/backend.php";
  static const ROOT_layt = "http://10.0.6.1/cs4391/le1010274/";

  //static const _CREATE_TABLE_ACTION = "CREATE_TABLE";
  //static const _GET_REC_ACTION = "GET_REC";

  static const _ADD_REC_ACTION = "ADD_REC";
  static const _GET_ALL_ACTION = "GET_ALL";
  static const _UPDATE_REC_ACTION = "UPDATE_REC";
  static const _DELETE_REC_ACTION = "DELETE_REC";

  static const _ADD_PROFILE_ACTION = "ADD_PROFILE";
  static const _ATTEMPT_LOGIN_ACTION = "ATTEMPT_LOGIN";
  static const _ATTEMPT_LOAD_PROFILE = "ATTEMPT_LOAD_PROFILE";

  static const _ADMIT_CUSTOMER = "ADMIT_CUSTOMER";
  static const _MAKE_RESERVATION = "MAKE_RESERVATION";
  static const _MAKE_CHOICE = "MAKE_CHOICE";
  static const _CHECK_FOR_SHOPPING_CUSTOMER = "CHECK_FOR_SHOPPING_CUSTOMER";
  static const _RELEASE_CUSTOMER = "RELEASE_CUSTOMER";

  /*
  static Future<String> createTable(String tableName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      map['table_name'] = tableName;

      final response = await http.post(ROOT, body: map);

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> getRec(String username) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_REC_ACTION;
      map['username'] = username;

      final response = await http.post(ROOT, body: map);

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
  */

  static Future<String> getMenuItems(String fileName, String menu, String needID) async {
    try {
      var map = Map<String, dynamic>();
      map['menu'] = menu;
      map['fileName'] = fileName;
      map['needID'] = needID;

      String path = ROOT_layt + "StoreSearch/GetStore.php";
      

      final response = await http.post(path, body: map);
      //print(response.body);

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> getSchedule(String state, String city, String store, String address ) async {
    try {
      var map = Map<String, dynamic>();
      //map['state'] = state;
      map['state'] = "TX";
      //map['city'] = city;
      map['city'] = "Amarillo";
      //map['store'] = store;
      map['store'] = "Rando Mart";
      //map['address'] = address;
      map['address'] = "3 Lancaster Road";
      map['storeUsername'] = "store_345";
      map['fileName'] = "sunday.json";

      String path = ROOT_layt + "Schedule/GetSchedule.php";
      

      final response = await http.post(path, body: map);
      print(response.body);

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }
  static Future<String> updateSchedule(String state, String city, String store, String address, String times, String partySize ) async {
    try {
      var map = Map<String, dynamic>();
      //map['state'] = state;
      map['state'] = "TX";
      //map['city'] = city;
      map['city'] = "Amarillo";
      //map['store'] = store;
      map['store'] = "Rando Mart";
      //map['address'] = address;
      map['address'] = "3 Lancaster Road";
      map['storeUsername'] = "store_345";
      map['fileName'] = "sunday.json";
      map['partySize'] = partySize;
      String startTime = times.split(" - ").first;
      String endTime = times.split(" - ").last;
      map['startTime'] = startTime;
      map['endTime'] = endTime;
      


      String path = ROOT_layt + "Schedule/UpdateSchedule.php";
      

      final response = await http.post(path, body: map);
      print(response.body);

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }


  static Future<String> getALLRecs(String tablename) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['tablename'] = tablename;

      final response = await http.post(ROOT, body: map);
      print('We are here.');
      print(response.body);
      print('Made it past.');

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  Future<String> addProfile(Map<String, dynamic> map, Type tableName) async {
    try {
      map['action'] = _ADD_PROFILE_ACTION;

      if (tableName == CustomerSignup)
        map["tablename"] = "CustomerProfiles";
      else
        map["tablename"] = "StoreProfiles";

      final response = await http.post(ROOT, body: map);

      if (response.statusCode == 200 && response.body != "error")
        return response.body;

      return "failure";
    } on TimeoutException catch (_) {
      return "timed out";
    } catch (e) {
      print(e);
      return "unexpected error";
    }
  }

  Future<String> attemptLogin(String username, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ATTEMPT_LOGIN_ACTION;
      map['username'] = username;
      map['password'] = password;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        window.localStorage["csrf"] = response.body;
        return response.body;
      }

      return "failure";
    } on TimeoutException catch (_) {
      return "timed out";
    } catch (e) {
      print(e);
      return "unexpected error";
    }
  }

  Future<String> attemptLoadProfile(String csrfToken) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ATTEMPT_LOAD_PROFILE;

      var header = Map<String, String>();
      header['csrf'] = csrfToken;

      final response = await http
          .post(ROOT, headers: header, body: map)
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> admitCustomer(
      String state,
      String city,
      String store,
      String address,
      String storeUsername,
      String customer,
      String visitStartBlock,
      String trueAdmittance) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADMIT_CUSTOMER;
      map['state'] = state;
      map['city'] = city;
      map['store'] = store;
      map['address'] = address;
      map['storeUsername'] = storeUsername;
      map['customer'] = customer;
      map['visitStartBlock'] = visitStartBlock;
      map['trueAdmittance'] = trueAdmittance;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> makeReservation(
      String state,
      String city,
      String store,
      String address,
      String storeUsername,
      String customer,
      String visitStartBlock,
      String storeCloseTime,
      String maxCapacity) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _MAKE_RESERVATION;
      map['state'] = state;
      map['city'] = city;
      map['store'] = store;
      map['address'] = address;
      map['storeUsername'] = storeUsername;
      map['customer'] = customer;
      map['visitStartBlock'] = visitStartBlock;
      map['storeCloseTime'] = storeCloseTime;
      map['maxCapacity'] = maxCapacity;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> makeChoice(
      String state,
      String city,
      String store,
      String address,
      String storeUsername,
      String customer,
      String option,
      String fullOrScheduledVisitStart,
      String nextTimeBlock,
      String endTime) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _MAKE_CHOICE;
      map['state'] = state;
      map['city'] = city;
      map['store'] = store;
      map['address'] = address;
      map['storeUsername'] = storeUsername;
      map['customer'] = customer;
      map['option'] = option;
      map['fullOrScheduledVisitStart'] = fullOrScheduledVisitStart;
      map['nextTimeBlock'] = nextTimeBlock;
      map['endTime'] = endTime;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> customerIsShopping(
      String state,
      String city,
      String store,
      String address,
      String storeUsername,
      String customer) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CHECK_FOR_SHOPPING_CUSTOMER;
      map['state'] = state;
      map['city'] = city;
      map['store'] = store;
      map['address'] = address;
      map['storeUsername'] = storeUsername;
      map['customer'] = customer;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static Future<String> releaseCustomer(
      String state,
      String city,
      String store,
      String address,
      String storeUsername,
      String customer,
      String visitStartBlock,
      String storeCloseTime,
      String maxCapacity) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _RELEASE_CUSTOMER;
      map['state'] = state;
      map['city'] = city;
      map['store'] = store;
      map['address'] = address;
      map['storeUsername'] = storeUsername;
      map['customer'] = customer;
      map['visitStartBlock'] = visitStartBlock;
      map['storeCloseTime'] = storeCloseTime;
      map['maxCapacity'] = maxCapacity;

      final response =
          await http.post(ROOT, body: map).timeout(Duration(seconds: 5));

      if (response.statusCode == 200 && response.body != "error") {
        return response.body;
      }

      return "failure";
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  static void updateJson(List<String> storeInfo) async {
    //String state = storeInfo[0];
    //String city = storeInfo[1];
    //String store = storeInfo[2];
    //String address = storeInfo[3];

    await Process.run('python', ['--version'], runInShell: true);
  }

  // method for showing a popup message. Similar to
  // a toast or snackbar, except the message will not
  // leave until the user dismisses it
  static void showAlertMessage(
      String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
      ),
    );
  }

  static void hideLoadingIndicator(BuildContext context) async {
    Navigator.of(context).pop();
  }

  // calling this method shows a circular loading icon
  // within an alert message. However, the alert message
  // that is generated cannot be dismissed by the user.
  // The system MUST dismiss this alert message before
  // finishing the rest of the code that called this method.
  static void showLoadingIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              backgroundColor: Colors.black87,
              content: Container(
                padding: EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "Loading. Please wait...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
