import 'package:clup/CustomerProfile/CustomerSignup.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'package:clup/testing/Services.dart';

class ServicesMock implements Services {
  ServicesMock(
      {this.id = "",
      this.failLoadProfile = false,
      this.mockUsername = "customer"});

  final String id;
  final bool failLoadProfile;
  String mockUsername;

  Future<String> addProfile(Map<String, dynamic> map, Type tableName) {
    if (id == "test_pass" && tableName == CustomerSignup)
      return Future.value("success");
    else if (id == "test_pass" && tableName == StoreSignup)
      return Future.value("success");
    else if (id == "test_timeout")
      return Future.value("timed out");
    else if (id == "test_unexpected_error")
      return Future.value("unexpected error");
    else
      return Future.value("failure");
  }

  Future<String> attemptLogin(String username, String password) async {
    if (id == "" && username == "customer" && password == "password00") {
      String payload =
          "0.eyJ1c2VybmFtZSI6ImN1c3RvbWVyIiwiYWNjVHlwZSI6ImN1c3RvbWVyIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTMzNjU0NzB9.2";
      return Future.value(payload);
    } else if (id == "" && username == "store" && password == "password00") {
      String payload =
          "0.eyJ1c2VybmFtZSI6InN0b3JlIiwiYWNjVHlwZSI6InN0b3JlIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTM0MzU0NTd9.2";
      return Future.value(payload);
    } else if (id == "test_timeout")
      return Future.value("timed out");
    else if (id == "test_unexpected_error")
      return Future.value("unexpected error");
    else
      return Future.value("failure");
  }

  Future<String> attemptLoadProfile(String csrfToken) async {
    if (id == "" && !failLoadProfile && mockUsername == "customer") {
      String data =
          '{"username":"customer","fname":"Hunter","lname":"Chambers","email":"some_email@place.com","phone":"(333) 333 - 3333"}';
      return Future.value(data);
    } else if (id == "" && !failLoadProfile && mockUsername == "store") {
      String data =
          '{"username":"store","open_time":"7:00AM","close_time":"11:00PM","capacity":"1500","address":"1234 Random Street","city":"Amarillo","state":"TX","zipcode":"79124"}';
      return Future.value(data);
    } else
      return Future.value("failure");
  }
}
