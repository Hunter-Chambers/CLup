import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:clup/testing/Services.dart';
import 'package:flutter/material.dart';
import 'StoreLogin.dart';

class StoreSignup extends StatefulWidget {
  final Services services;
  final StoreProfileController storeProfile;

  // helps validate the form
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = new TextEditingController();

  StoreSignup({Key key, this.services, this.storeProfile}) : super(key: key);

  @override
  _StoreSignupState createState() => _StoreSignupState();
}

class _StoreSignupState extends State<StoreSignup> {
  String _openAmPm = "AM";
  String _closeAmPm = "AM";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.storeProfile.reset();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // color for whole page
        backgroundColor: Color.fromARGB(100, 107, 255, 245),
        appBar: AppBar(title: Text("This is the Store signup page")),

        body: Center(
          // center white column
          child: Container(
            color: Colors.white,
            width: 700,
            child: ListView(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
              children: <Widget>[
                Form(
                  key: widget._formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //
                      // username field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller:
                              widget.storeProfile.getTextController("username"),
                          validator: (String value) {
                            if (value.length <= 0) {
                              return "Invalid username";
                            }
                            if (value.contains(
                                new RegExp(r'[\\/%&*()=\[\]{}":;\.,<>? ]'))) {
                              return "Must not contain \\/%&*()=[]{}\":;.,<>? or spaces";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username *",
                          ),
                        ),
                      ),

                      // password field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: widget.passwordController,
                          validator: (String value) {
                            if (value.length < 10) {
                              return "Must be at least 10 characters";
                            }
                            if (value.contains(
                                new RegExp(r'[\\/%&*()=\[\]{}":;\.,<>? ]'))) {
                              return "Must not contain \\/%&*()=[]{}\":;.,<>? or spaces";
                            }
                            if (value.contains(widget.storeProfile
                                .getTextController("username")
                                .text)) {
                              return "Must not contain the username";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password *",
                          ),
                        ),
                      ),

                      // password check field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          obscureText: true,
                          validator: (String value) {
                            if (!value.contains(new RegExp(r'^' +
                                    widget.passwordController.text +
                                    r'$')) ||
                                value.length <= 0) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Retype Password *",
                          ),
                        ),
                      ),

                      // store name field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: widget.storeProfile
                              .getTextController("store_name"),
                          validator: (String value) {
                            if (!value
                                .contains(new RegExp(r"^([ a-zA-Z'-])+$"))) {
                              return "Must only contain ' - and letters.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Store Name *",
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          // store address field
                          Container(
                            width: 180,
                            margin: EdgeInsets.only(right: 25, bottom: 20),
                            child: TextFormField(
                              controller: widget.storeProfile
                                  .getTextController("address"),
                              validator: (String value) {
                                if (!value.contains(new RegExp(
                                    r"^([0-9])+ ([ a-zA-Z0-9'-])+$"))) {
                                  return "Must be a valid\nstreet address";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Store Street Address *",
                              ),
                            ),
                          ),

                          // city field
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 25, bottom: 20),
                            child: TextFormField(
                              controller:
                                  widget.storeProfile.getTextController("city"),
                              validator: (String value) {
                                if (!value.contains(
                                    new RegExp(r"^([ a-zA-Z'-])+$"))) {
                                  return "Must be a valid\ncity name.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "City *",
                              ),
                            ),
                          ),

                          // state field
                          Container(
                            width: 70,
                            margin: EdgeInsets.only(right: 25, bottom: 20),
                            child: TextFormField(
                              controller: widget.storeProfile
                                  .getTextController("state"),
                              validator: (String value) {
                                if (!value.contains(
                                    new RegExp(r"^([a-zA-Z]){2,2}$"))) {
                                  return "Must be\nin the\nform XX.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "State *",
                              ),
                            ),
                          ),

                          // zip field
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: widget.storeProfile
                                  .getTextController("zipcode"),
                              validator: (String value) {
                                if (!value
                                    .contains(new RegExp(r"^([0-9]){5,5}$"))) {
                                  return "Must be a\nvalid zip code.";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Zip Code *",
                              ),
                            ),
                          ),
                        ],
                      ),

                      // holds the hours information
                      Row(
                        children: <Widget>[
                          // store open field
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 25, bottom: 20),
                            child: TextFormField(
                              controller: widget.storeProfile
                                  .getTextController("open_time"),
                              validator: (String value) {
                                if (!(value.contains(
                                        new RegExp(r'^1[0-2]:[0-5][0-9]$')) ||
                                    value.contains(
                                        new RegExp(r'^0[1-9]:[0-5][0-9]$')) ||
                                    value.contains(
                                        new RegExp(r'^[1-9]:[0-5][0-9]$')))) {
                                  return "Please input as XX:XX\ne.g. 1:00";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Store Open *",
                              ),
                            ),
                          ),

                          // hide the tooltip that comes
                          // with a default popup menu button
                          TooltipTheme(
                            data: TooltipThemeData(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),

                            // open am/pm button
                            child: PopupMenuButton(
                              tooltip: '',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_openAmPm),
                                  Icon(
                                    Icons.arrow_right,
                                  ),
                                ],
                              ),

                              // list of items
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: "AM",
                                  child: Text("AM"),
                                ),
                                PopupMenuItem<String>(
                                  value: "PM",
                                  child: Text("PM"),
                                )
                              ],

                              // what happens when an
                              // item is selected
                              onSelected: (String value) {
                                setState(() {
                                  _openAmPm = value;
                                });
                              },
                            ),
                          ),

                          // store close field
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(
                                left: 50, right: 25, bottom: 20),
                            child: TextFormField(
                              controller: widget.storeProfile
                                  .getTextController("close_time"),
                              validator: (String value) {
                                if (!(value.contains(
                                        new RegExp(r'^1[0-2]:[0-5][0-9]$')) ||
                                    value.contains(
                                        new RegExp(r'^0[1-9]:[0-5][0-9]$')) ||
                                    value.contains(
                                        new RegExp(r'^[1-9]:[0-5][0-9]$')))) {
                                  return "Please input as XX:XX\ne.g. 1:00";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Store Close *",
                              ),
                            ),
                          ),

                          // hide the tooltip that comes
                          // with a default popup menu button
                          TooltipTheme(
                            data: TooltipThemeData(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),

                            // close am/pm button
                            child: PopupMenuButton(
                              tooltip: '',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_closeAmPm),
                                  Icon(
                                    Icons.arrow_right,
                                  ),
                                ],
                              ),

                              // list of items
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: "AM",
                                  child: Text("AM"),
                                ),
                                PopupMenuItem<String>(
                                  value: "PM",
                                  child: Text("PM"),
                                )
                              ],

                              // what happens when an
                              // item is selected
                              onSelected: (String value) {
                                setState(() {
                                  _closeAmPm = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // capacity field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller:
                              widget.storeProfile.getTextController("capacity"),
                          validator: (String value) {
                            if (value.contains(new RegExp(r'[^0-9$]')) ||
                                value.length <= 0) {
                              return "Must only contain numbers";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Store Capacity *",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // holds the submit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: FloatingActionButton.extended(
                        heroTag: "SubmitBtn",
                        onPressed: () async {
                          if (widget._formKey.currentState.validate()) {
                            Services.showLoadingIndicator(context);

                            widget.storeProfile
                                .formatFields(_openAmPm, _closeAmPm);

                            Map<String, dynamic> map = {
                              "username": widget.storeProfile
                                  .getTextController("username")
                                  .text,
                              "password": widget.passwordController.text,
                              "store_name": widget.storeProfile
                                  .getTextController("store_name")
                                  .text,
                              "open_time": widget.storeProfile
                                  .getTextController("open_time")
                                  .text,
                              "close_time": widget.storeProfile
                                  .getTextController("close_time")
                                  .text,
                              "capacity": widget.storeProfile
                                  .getTextController("capacity")
                                  .text,
                              "address": widget.storeProfile
                                  .getTextController("address")
                                  .text,
                              "city": widget.storeProfile
                                  .getTextController("city")
                                  .text,
                              "state": widget.storeProfile
                                  .getTextController("state")
                                  .text,
                              "zipcode": widget.storeProfile
                                  .getTextController("zipcode")
                                  .text,
                            };

                            String result = await widget.services
                                .addProfile(map, StoreSignup);

                            Services.hideLoadingIndicator(context);

                            if (result == "failure") {
                              Services.showAlertMessage(
                                  "Failed to Create Profile",
                                  "That username already exists",
                                  context);
                            } else if (result == "timed out") {
                              Services.showAlertMessage(
                                  "Failed to Create Profile",
                                  "Connection timed out",
                                  context);
                            } else if (result == "unexpected error") {
                              Services.showAlertMessage(
                                  "Failed to Create Profile",
                                  "An unexpected error occurred",
                                  context);
                            } else {
                              _onButtonPressed(context, 1);
                            }
                          }
                        },
                        label: Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onButtonPressed(BuildContext context, int option) {
    switch (option) {
      case 1:
        {
          widget.storeProfile.reset();
          Navigator.pop(context);
          return Services.showAlertMessage("Profile Successfully Created",
              "Your profile was created!\nPlease log in.", context);
        }
    }
  }
}
