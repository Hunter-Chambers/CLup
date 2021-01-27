import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Services {
  static const ROOT = "http://10.0.6.1/[PATH_TO_SCRIPT]/database.php";
  static const _CREATE_TABLE_ACTION = "CREATE_TABLE";
  static const _GET_ALL_ACTION = "GET_ALL";
  static const _ADD_REC_ACTION = "ADD_REC";
  static const _UPDATE_REC_ACTION = "UPDATE_REC";
  static const _DELETE_REC_ACTION = "DELETE_REC";

  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;

      final response = await http.post(ROOT, body: map);

      print("Create table response: ${response.body}");

      return response.body;
    } catch (e) {
      return "error";
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
}
