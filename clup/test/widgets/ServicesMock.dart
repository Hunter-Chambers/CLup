import 'package:clup/testing/Services.dart';

class ServicesMock implements Services {
  ServicesMock(
      {this.id = "",
      this.failLoadProfile = false,
      this.mockUsername = "customer"});

  final String id;
  final bool failLoadProfile;
  String mockUsername;

  Future<String> getALLRec(String tablename) async {
    String payload = '';
    if ( tablename == 'States' ) {
      payload = 'Oklahoma, NewMexico, Texas';
    }
    else if ( tablename == 'Oklahoma') {
      payload = 'Norman, Oklahoma City, Stillwater';
    }
    else if ( tablename == 'NewMexico' ) {
      payload = 'Albuquerque, Angel Fire, Santa Fe';
    }
    else if ( tablename == 'Texas' ) {
      payload = 'Amarillo, Dallas, Lubbock';
    }
    else if (tablename == 'Stores') {
      payload = 'HEB, United Supermarket, Walmart';
    }
    else if (tablename == 'Addresses') {
      payload = '111 SomeRoad, 222 SomeLane, 333 SomeStreet';
    }

    return Future.value(payload);
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
