import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:flutter/material.dart';
//import 'StoreLogin.dart';

class StoreEdit extends StatefulWidget {
  final StoreProfileController storeProfile;
  StoreEdit({Key key, this.storeProfile}) : super(key: key);

  @override
  _StoreEditState createState() => _StoreEditState(storeProfile: storeProfile);
}

class _StoreEditState extends State<StoreEdit> {
  final StoreProfileController storeProfile;
  _StoreEditState({this.storeProfile});

  // helps validate the form
  final _formKey = GlobalKey<FormState>();

  String _openAmPm = "";
  String _closeAmPm = "";

  initState() {
    final int _openLen =
        storeProfile.getTextController("open_time").text.length;
    final int _closeLen =
        storeProfile.getTextController("close_time").text.length;

    _openAmPm = storeProfile
        .getTextController("open_time")
        .text
        .substring(_openLen - 2);
    _closeAmPm = storeProfile
        .getTextController("close_time")
        .text
        .substring(_closeLen - 2);

    storeProfile.getTextController("open_time").text = storeProfile
        .getTextController("open_time")
        .text
        .substring(0, _openLen - 2);
    storeProfile.getTextController("close_time").text = storeProfile
        .getTextController("close_time")
        .text
        .substring(0, _closeLen - 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color for whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("This is the Store edit page")),

      body: Center(
        // center white column
        child: Container(
          color: Colors.white,
          width: 700,
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //
                    // username field
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: storeProfile.getTextController("username"),
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
                        controller: storeProfile.getTextController("password"),
                        validator: (String value) {
                          if (value.length < 10) {
                            return "Must be at least 10 characters";
                          }
                          if (value.contains(
                              new RegExp(r'[\\/%&*()=\[\]{}":;\.,<>? ]'))) {
                            return "Must not contain \\/%&*()=[]{}\":;.,<>? or spaces";
                          }
                          if (value.contains(storeProfile
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
                          if (!value.contains(storeProfile
                                  .getTextController("password")
                                  .text) ||
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

                    // holds the hours information
                    Row(
                      children: <Widget>[
                        // store open field
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 25, bottom: 20),
                          child: TextFormField(
                            controller:
                                storeProfile.getTextController("open_time"),
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
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
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
                          margin:
                              EdgeInsets.only(left: 50, right: 25, bottom: 20),
                          child: TextFormField(
                            controller:
                                storeProfile.getTextController("close_time"),
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
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
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
                        controller: storeProfile.getTextController("capacity"),
                        validator: (String value) {
                          if (value.contains(new RegExp(r'[^0-9]')) ||
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _onButtonPressed(context, 1);
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
    );
  }

  _onButtonPressed(BuildContext context, int option) {
    switch (option) {
      case 1:
        {
          String time = storeProfile.getTextController("open_time").text;
          time += _openAmPm;
          storeProfile.getTextController("open_time").text = time;

          time = storeProfile.getTextController("close_time").text;
          time += _closeAmPm;
          storeProfile.getTextController("close_time").text = time;

          /*
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreLogin(
                  storeController: storeProfile,
                  snackFlag: 1,
                ),
              ));
          */
          Navigator.pop(context, storeProfile);
        }
    }
  }
}
