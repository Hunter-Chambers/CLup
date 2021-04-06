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
  final String title;
  final Services services;

  HomePage({Key key, this.title, this.services}) : super(key: key);

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
    "party_size",
  ]);
  StoreProfileController storeProfile = StoreProfileController([
    "username",
    "store_name",
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
    spreadRadius: 0.8,
    blurRadius: 5,
    offset: Offset(0, 8),
  );

  @override
  Widget build(BuildContext context) {
    // the height and width of the window
    final double bodyHeight = MediaQuery.of(context).size.height;
    final double bodyWidth = MediaQuery.of(context).size.width;

    // the width of the center white column
    double width = 0.5 * bodyWidth;

    if (width < 960) {
      width = (960 <= bodyWidth) ? 960 : bodyWidth;
    }

    return Scaffold(
      // background for whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),

      body: Center(
        // center white box
        child: Container(
          color: Colors.white,
          height: bodyHeight,
          width: width,

          // putting the items in a listview allows for resizing
          // the window without receiving any errors
          child: ListView(
            children: <Widget>[
              // the title of the page
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 200, 0, 40),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // holds our text fields and buttons
              Column(
                children: <Widget>[
                  // holds the text fields in a row
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // username field
                        Container(
                          padding: EdgeInsets.only(right: 25),
                          width: textfieldWidth(width),
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
                          padding: EdgeInsets.only(left: 25),
                          width: textfieldWidth(width),
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

                  // holds the buttons in a row
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Login button
                        Container(
                          margin: EdgeInsets.only(top: 25, right: 25),
                          height: 43,
                          width: 125,
                          child: FloatingActionButton.extended(
                            heroTag: "LoginBtn",
                            onPressed: () async {
                              Services.showLoadingIndicator(context);

                              String result =
                                  await widget.services.attemptLogin(
                                _usernameController.text,
                                _passwordController.text,
                              );

                              _passwordController.clear();

                              if (result == "failure") {
                                Services.hideLoadingIndicator(context);
                                Services.showAlertMessage(
                                    "Login Failed",
                                    "Username or Password is incorrect",
                                    context);
                              } else if (result == "timed out") {
                                Services.hideLoadingIndicator(context);
                                Services.showAlertMessage("Login Failed",
                                    "Connection timed out", context);
                              } else if (result == "unexpected error") {
                                Services.hideLoadingIndicator(context);
                                Services.showAlertMessage("Login Failed",
                                    "An unexpected error occurred", context);
                              } else {
                                String userRecord = await widget.services
                                    .attemptLoadProfile(result);

                                if (userRecord == "failure") {
                                  Services.hideLoadingIndicator(context);
                                  Services.showAlertMessage(
                                      "Loading Profile Failed",
                                      "An unexpected error occurred",
                                      context);
                                } else {
                                  _usernameController.clear();

                                  Services.hideLoadingIndicator(context);

                                  Map<String, dynamic> payload = json.decode(
                                      ascii.decode(base64.decode(base64
                                          .normalize(result.split(".")[1]))));
                                  Map<String, dynamic> recordValues =
                                      json.decode(userRecord);

                                  if (payload["accType"] == "customer") {
                                    customerProfile
                                        .getTextController("username")
                                        .text = recordValues["username"];
                                    customerProfile
                                        .getTextController("fname")
                                        .text = recordValues["fname"];
                                    customerProfile
                                        .getTextController("lname")
                                        .text = recordValues["lname"];
                                    customerProfile
                                        .getTextController("email")
                                        .text = recordValues["email"];
                                    customerProfile
                                        .getTextController("phone")
                                        .text = recordValues["phone"];

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
                                    storeProfile
                                        .getTextController("username")
                                        .text = recordValues["username"];
                                    storeProfile
                                        .getTextController("store_name")
                                        .text = recordValues["store_name"];
                                    storeProfile
                                        .getTextController("open_time")
                                        .text = recordValues["open_time"];
                                    storeProfile
                                        .getTextController("close_time")
                                        .text = recordValues["close_time"];
                                    storeProfile
                                        .getTextController("capacity")
                                        .text = recordValues["capacity"];
                                    storeProfile
                                        .getTextController("address")
                                        .text = recordValues["address"];
                                    storeProfile
                                        .getTextController("city")
                                        .text = recordValues["city"];
                                    storeProfile
                                        .getTextController("state")
                                        .text = recordValues["state"];
                                    storeProfile
                                        .getTextController("zipcode")
                                        .text = recordValues["zipcode"];

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
                          margin: EdgeInsets.only(top: 25),
                          color: Color.fromARGB(255, 224, 224, 224),
                          width: 3,
                          height: 100,
                        ),

                        // holds the sign-up button
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 25),
                          height: 43,
                          width: 125,

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
                                key: Key("signUpBtn"),
                                tooltip: '',

                                // holds the signup text and icon
                                // that appear on the signup button
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // signup text
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 10),
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
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
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
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    key: Key("customerMenuItem"),
                                    value: "Customer",
                                    child: Text("Customer"),
                                  ),
                                  PopupMenuItem<String>(
                                    key: Key("storeMenuItem"),
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
                child: Text(
                  "A brief description about CLup will go here, along "
                  "with why CLup was developed.",
                ),
              ),

              // ***********************************************************
              // ***********************************************************
              // ***********************************************************
              // quick login for devs
              FloatingActionButton.extended(
                heroTag: "quickCustomerLogin",
                label: Text("Customer"),
                onPressed: () {
                  String result =
                      "0.eyJ1c2VybmFtZSI6ImN1c3RvbWVyIiwiYWNjVHlwZSI6ImN1c3RvbWVyIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTMzNjU0NzB9.2";
                  Map<String, dynamic> payload = json.decode(ascii.decode(
                      base64.decode(base64.normalize(result.split(".")[1]))));
                  Map<String, dynamic> recordValues = json.decode(
                      '{"username":"customer","fname":"Hunter","lname":"Chambers","email":"some_email@place.com","phone":"(333) 333 - 3333"}');

                  customerProfile.getTextController("username").text =
                      recordValues["username"];
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
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickStoreLogin",
                label: Text("Store"),
                onPressed: () {
                  String result =
                      "0.eyJ1c2VybmFtZSI6InN0b3JlIiwiYWNjVHlwZSI6InN0b3JlIiwidHlwZSI6ImNzcmYiLCJleHAiOjE2MTM0MzU0NTd9.2";
                  Map<String, dynamic> payload = json.decode(ascii.decode(
                      base64.decode(base64.normalize(result.split(".")[1]))));
                  Map<String, dynamic> recordValues = json.decode(
                      '{"username":"store","store_name":"Rando Store","open_time":"7:00AM","close_time":"11:00PM","capacity":"1500","address":"1234 Random Street","city":"Amarillo","state":"TX","zipcode":"79124"}');

                  storeProfile.getTextController("username").text =
                      recordValues["username"];
                  storeProfile.getTextController("store_name").text =
                      recordValues["store_name"];
                  storeProfile.getTextController("open_time").text =
                      recordValues["open_time"];
                  storeProfile.getTextController("close_time").text =
                      recordValues["close_time"];
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
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickAdmitCustomer",
                label: Text("Admit Customer"),
                onPressed: () async {
                  String state = "TX";
                  String city = "Amarillo";
                  String store = "\"Rando Mart\"";
                  String address = "\"3 Lancaster Road\"";
                  String storeUsername = "store_345";
                  String customer =
                      '\"{\\"Hunter\\": {\\"contact_info\\": \\"email@place.com\\", \\"party_size\\": 2, \\"type\\": \\"scheduled\\", \\"visit_length\\": 3}}\"';
                  String visitStartBlock = "0800";
                  String trueAdmittance = "True";

                  String result = await Services.admitCustomer(
                      state,
                      city,
                      store,
                      address,
                      storeUsername,
                      customer,
                      visitStartBlock,
                      trueAdmittance);
                  print(result);
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickMakeReservation",
                label: Text("Make ASAP Reservation"),
                onPressed: () async {
                  String state = "TX";
                  String city = "Amarillo";
                  String store = "\"Rando Mart\"";
                  String address = "\"3 Lancaster Road\"";
                  String storeUsername = "store_345";
                  String customer =
                      '\"{\\"Hunter\\": {\\"contact_info\\": \\"email@place.com\\", \\"party_size\\": 2, \\"type\\": \\"scheduled\\", \\"visit_length\\": 3}}\"';
                  String visitStartBlock = "ASAP";
                  String storeCloseTime = "2300";
                  String maxCapacity = "100";

                  String result = await Services.makeReservation(
                      state,
                      city,
                      store,
                      address,
                      storeUsername,
                      customer,
                      visitStartBlock,
                      storeCloseTime,
                      maxCapacity);
                  print(result);
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickMakeChoice",
                label: Text("Select Option B"),
                onPressed: () async {
                  String state = "TX";
                  String city = "Amarillo";
                  String store = "\"Rando Mart\"";
                  String address = "\"3 Lancaster Road\"";
                  String storeUsername = "store_345";
                  String customer =
                      '\"{\\"Hunter\\": {\\"contact_info\\": \\"email@place.com\\", \\"party_size\\": 2, \\"type\\": \\"scheduled\\", \\"visit_length\\": 3}}\"';
                  String option = "B";
                  String fullOrScheduledVisitStart = "False";
                  String nextTimeBlock = "0815";
                  String endTime = "0915";

                  String result = await Services.makeChoice(
                      state,
                      city,
                      store,
                      address,
                      storeUsername,
                      customer,
                      option,
                      fullOrScheduledVisitStart,
                      nextTimeBlock,
                      endTime);
                  print(result);
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickCheckForShopping",
                label: Text("Check if Customer is Shopping"),
                onPressed: () async {
                  String state = "TX";
                  String city = "Amarillo";
                  String store = "\"Rando Mart\"";
                  String address = "\"3 Lancaster Road\"";
                  String storeUsername = "store_345";
                  String customer =
                      '\"{\\"Hunter\\": {\\"contact_info\\": \\"email@place.com\\", \\"party_size\\": 2, \\"type\\": \\"scheduled\\", \\"visit_length\\": 3}}\"';

                  String result = await Services.customerIsShopping(
                      state, city, store, address, storeUsername, customer);
                  print(result);
                },
              ),

              FloatingActionButton.extended(
                heroTag: "quickReleaseCustomer",
                label: Text("Release Customer"),
                onPressed: () async {
                  String state = "TX";
                  String city = "Amarillo";
                  String store = "\"Rando Mart\"";
                  String address = "\"3 Lancaster Road\"";
                  String storeUsername = "store_345";
                  String customer =
                      '\"{\\"Hunter\\": {\\"contact_info\\": \\"email@place.com\\", \\"party_size\\": 2, \\"type\\": \\"scheduled\\", \\"visit_length\\": 3}}\"';
                  String visitStartBlock = "0800";
                  String storeCloseTime = "2300";
                  String maxCapacity = "100";

                  String result = await Services.releaseCustomer(
                      state,
                      city,
                      store,
                      address,
                      storeUsername,
                      customer,
                      visitStartBlock,
                      storeCloseTime,
                      maxCapacity);
                  print(result);
                },
              ),
              // ***********************************************************
              // ***********************************************************
              // ***********************************************************
            ],
          ),
        ),
      ),
    );
  }

  // allows the textfields to be dynamically sized as
  // the window changes sizes
  double textfieldWidth(double width) {
    return (width >= 600) ? width / 4 : width / 2.5;
  }

  // method for dynamically updating the signup
  // button's shadow when the mouse is over it
  _updateShadow(option) {
    if (option == 1) {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.8,
          blurRadius: 8,
          offset: Offset(0, 10),
        );
      });
    } else {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.8,
          blurRadius: 5,
          offset: Offset(0, 8),
        );
      });
    }
  }

  _onButtonPressed(BuildContext context, int option) {
    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSignup(
                  key: Key("customerSignupPage"),
                  services: widget.services,
                  customerProfile: customerProfile,
                ),
              ));
        }
        break;
      case 2:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSignup(
                  key: Key("storeSignupPage"),
                  services: widget.services,
                  storeProfile: storeProfile,
                ),
              ));
        }
        break;
    }
  }
}
