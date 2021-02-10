import 'dart:convert';

import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'CustomerProfile/CustomerLogin.dart';
import 'CustomerProfile/CustomerSignup.dart';
import 'StoreProfile/StoreLogin.dart';
import 'StoreProfile/StoreSignup.dart';
import 'testing/Services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.services}) : super(key: key);

  final String title;
  final Services services;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controllers to get text from username and password fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // profile controllers
  CustomerProfileController customerProfile = CustomerProfileController([
    "username",
    "fname",
    "lname",
    "email",
    "phone",
  ]);
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

  // shadow for the sign up button
  BoxShadow signupShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0.5,
    blurRadius: 5,
    offset: Offset(5, 5),
  );

  // ******************************************
  // test functions
  // ******************************************

  @override
  Widget build(BuildContext context) {
    // ******************************************
    // test variables
    final double bodyHeight = MediaQuery.of(context).size.height;
    final double bodyWidth = MediaQuery.of(context).size.width;

    double width = 0.5 * bodyWidth;

    if (width < 960) {
      width = (960 <= bodyWidth) ? 960 : bodyWidth;
    }
    // ******************************************

    return Scaffold(
      // background for whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),

      body: Center(
        // center white box
        child: Container(
          color: Colors.white,
          height: bodyHeight,
          width: width,
          // ******************************************
          //height: 500,
          //width: 700,
          // ******************************************

          // putting the items in a listview allows for resizing
          // the window without receiving any errors
          child: ListView(
            children: <Widget>[
              // the title of the page
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // holds our text fields and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // holds the text fields in a column
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                    // ******************************************
                    //width: 200,
                    // ******************************************
                    width: width / 3,
                    child: Column(
                      children: <Widget>[
                        // username field
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextField(
                            key: Key("userField"),
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                            ),
                          ),
                        ),

                        // password field
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            key: Key("passField"),
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Login button
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    // ******************************************
                    height: 43,
                    width: 960 / 6 - 35,
                    // ******************************************
                    child: FloatingActionButton.extended(
                      heroTag: "LoginBtn",
                      onPressed: () async {
                        _showLoadingIndicator();

                        String result = await widget.services.attemptLogin(
                          _usernameController.text,
                          _passwordController.text,
                        );

                        if (result == "failure") {
                          _hideLoadingIndicator();
                          _showAlertMessage("Login Failed",
                              "Username or Password is incorrect");
                        } else if (result == "timed out") {
                          _hideLoadingIndicator();
                          _showAlertMessage(
                              "Login Failed", "Connection timed out");
                        } else if (result == "unexpected error") {
                          _hideLoadingIndicator();
                          _showAlertMessage(
                              "Login Failed", "An unexpected error occurred");
                        } else {
                          String userRecord =
                              await widget.services.attemptLoadProfile(result);

                          if (userRecord == "failure") {
                            _hideLoadingIndicator();
                            _showAlertMessage("Loading Profile Failed",
                                "An unexpected error occurred");
                          } else {
                            _hideLoadingIndicator();

                            Map<String, dynamic> payload = json.decode(
                                ascii.decode(base64.decode(
                                    base64.normalize(result.split(".")[1]))));
                            Map<String, dynamic> recordValues =
                                json.decode(userRecord);

                            if (payload["accType"] == "customer") {
                              customerProfile
                                  .getTextController("username")
                                  .text = recordValues["username"];
                              customerProfile.getTextController("fname").text =
                                  recordValues["fname"];
                              customerProfile.getTextController("lname").text =
                                  recordValues["lname"];
                              customerProfile.getTextController("email").text =
                                  recordValues["email"];
                              customerProfile.getTextController("phone").text =
                                  recordValues["phone"];

                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerLogin(
                                    key: Key("customerLoginPage"),
                                    jwt: result,
                                    payload: payload,
                                    customerController: customerProfile,
                                  ),
                                ),
                              );
                            } else {
                              storeProfile.getTextController("username").text =
                                  recordValues["username"];
                              storeProfile.getTextController("open_time").text =
                                  recordValues["open_time"];
                              storeProfile
                                  .getTextController("close_time")
                                  .text = recordValues["close_time"];
                              storeProfile.getTextController("capacity").text =
                                  recordValues["capacity"];
                              storeProfile.getTextController("address").text =
                                  recordValues["address"];
                              storeProfile.getTextController("city").text =
                                  recordValues["city"];
                              storeProfile.getTextController("state").text =
                                  recordValues["state"];
                              storeProfile.getTextController("zipcode").text =
                                  recordValues["zipcode"];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreLogin(
                                    key: Key("storeLoginPage"),
                                    jwt: result,
                                    payload: payload,
                                    storeController: storeProfile,
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      label: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.7,
                        ),
                      ),
                    ),
                  ),

                  // vertical divider
                  Container(
                    color: Color.fromARGB(255, 224, 224, 224),
                    width: 3,
                    height: 100,
                  ),

                  // holds the sign-up button
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    // ******************************************
                    height: 43,
                    width: 960 / 6 - 35,
                    // ******************************************

                    // this gives the button the blue, rounded look
                    // as well as a shadow
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color.fromARGB(255, 33, 150, 243),
                      boxShadow: [signupShadow],
                    ),

                    // hide the tooltip that comes
                    // with the popup menu button
                    child: TooltipTheme(
                      data: TooltipThemeData(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),

                      // update the shadow when the
                      // mouse is over the button
                      child: MouseRegion(
                        onHover: (e) => _updateShadow(1),
                        onExit: (e) => _updateShadow(0),

                        // the actual signup button
                        child: PopupMenuButton(
                          tooltip: '',

                          // holds the signup text and icon
                          // that appear on the signup button
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // signup text
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 12, 10, 12),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.7,
                                  ),
                                ),
                              ),

                              // icon
                              Container(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // what happens when an item is selected
                          onSelected: (String value) {
                            setState(() {
                              if (value == "Customer") {
                                _onButtonPressed(context, 1);
                              } else {
                                _onButtonPressed(context, 2);
                              }
                            });
                          },

                          // list of items
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "Customer",
                              child: Text("Customer"),
                            ),
                            PopupMenuItem<String>(
                              value: "Store",
                              child: Text("Store"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // horizontal divider
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
              ),

              // description text
              Container(
                padding: EdgeInsets.fromLTRB(50, 35, 50, 52),
                child:
                    Text("A brief description about CLup will go here, along "
                        "with why CLup was developed."),
              ),

              // Create Table button
              FloatingActionButton.extended(
                heroTag: "createtabletag",
                onPressed: () async {
                  String result = await Services.createTable("huntertable");

                  if (result == "failure") {
                    //_hideLoadingIndicator();
                    _showAlertMessage(
                        "Table Creation Failed", "Failed to create table");
                  }
                },
                label: Text("Create Table"),
              ),

              // Add Record button
              FloatingActionButton.extended(
                heroTag: "addrectag",
                onPressed: () async {
                  if (_usernameController.text == "" ||
                      _passwordController.text == "") {
                    _showAlertMessage("Adding Profile Failed",
                        "Username or Password is empty");
                  } else {
                    String result = await Services.addRec(
                        _usernameController.text,
                        _passwordController.text,
                        "Hunter",
                        "Chambers",
                        "some_email@place.com",
                        "(333) 333 - 3333");

                    if (result == "failure") {
                      _showAlertMessage(
                          "Adding Profile Failed", "Failed to add the profile");
                    }
                  }
                },
                label: Text("Add Record"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // method for dynamically updating the signup
  // button's shadow when the mouse is over it
  _updateShadow(option) {
    if (option == 1) {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 10,
          offset: Offset(5, 5),
        );
      });
    } else {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 5,
          offset: Offset(5, 5),
        );
      });
    }
  }

  _showAlertMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
      ),
    );
  }

  _hideLoadingIndicator() async {
    Navigator.of(context).pop();
  }

  _showLoadingIndicator() {
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

  _onButtonPressed(BuildContext context, int option) {
    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSignup(),
              ));
        }
        break;
      case 2:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSignup(),
              ));
        }
        break;
    }
  }
}
