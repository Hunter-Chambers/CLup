// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Services {
  static const ROOT = "http://10.0.6.1/cs4391/le1010274/backend.php";
  static const _CREATE_TABLE_ACTION = "CREATE_TABLE";
  static const _ADD_REC_ACTION = "ADD_REC";
  static const _GET_REC_ACTION = "GET_REC";
  static const _GET_ALL_ACTION = "GET_ALL";
  static const _UPDATE_REC_ACTION = "UPDATE_REC";
  static const _DELETE_REC_ACTION = "DELETE_REC";

  static const _ATTEMPT_LOGIN_ACTION = "ATTEMPT_LOGIN";
  static const _ATTEMPT_LOAD_PROFILE = "ATTEMPT_LOAD_PROFILE";

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

  static Future<String> addRec(String username, String password, String fname,
      String lname, String email, String phone) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_REC_ACTION;
      map['username'] = username;
      map['password'] = password;
      map['fname'] = fname;
      map['lname'] = lname;
      map['email'] = email;
      map['phone'] = phone;

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

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
}
