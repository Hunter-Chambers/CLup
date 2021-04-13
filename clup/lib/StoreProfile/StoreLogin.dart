import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:flutter/material.dart';
import 'package:jsqr/scanner.dart';
import 'dart:convert';
import 'StoreEdit.dart';
import 'package:clup/Services/Services.dart';

class StoreLogin extends StatefulWidget {
  final StoreProfileController storeController;
  final String jwt;
  final Map<String, dynamic> payload;

  StoreLogin({Key key, this.jwt, this.payload, this.storeController})
      : super(key: key);

  @override
  _StoreLoginState createState() => _StoreLoginState(
        jwt: jwt,
        payload: payload,
        storeController: storeController,
      );
}

class _StoreLoginState extends State<StoreLogin> {
  StoreProfileController storeController;
  String jwt;
  Map<String, dynamic> payload;
  _StoreLoginState({this.jwt, this.payload, this.storeController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color for the whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),

      body: Center(
        // center white box
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,

          // holds all the info on the page
          child: ListView(
            children: <Widget>[
              // page title
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  'Store Profile Page',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // profile info listed
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Username: " +
                      storeController.getTextController("username").text +
                      "\n" +
                      "Open Hours: " +
                      storeController.getTextController("open_time").text +
                      " - " +
                      storeController.getTextController("close_time").text +
                      "\n" +
                      "Capacity: " +
                      storeController.getTextController("capacity").text +
                      "\n",
                ),
              ),

              // horizontal divider
              Container(
                alignment: Alignment.center,
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
              ),

              // edit info button
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "S_EditBtn",
                  onPressed: () => _onButtonPressed(context, 1),
                  label: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // scan QR code button
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "S_QRBtn",
                  onPressed: () => _openScan(),
                  label: Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // testing button
              /*
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "testBtn",
                  onPressed: () => _onButtonPressed(context, 3),
                  label: Text(
                    "Test",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Updated changes successfully.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openScan() async {
    var code = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Scan QR Code'),
            content: Container(width: 640, height: 480, child: Scanner()),
          );
        });

    List<String> info = code.split(";");
    String customer = json.encode({
      info[0]: {
        'contact_info': info[1],
        'party_size': int.parse(info[2]),
        'type': info[3],
        'visit_length': int.parse(info[4])
      }
    }).replaceAll("\"", "\\\"");

    String state = json.encode(storeController.getTextController('state').text);
    String city = json.encode(storeController.getTextController('city').text);
    String store =
        json.encode(storeController.getTextController('store_name').text);
    String address =
        json.encode(storeController.getTextController('address').text);
    String storeUsername = storeController.getTextController('username').text;

    Services.showLoadingIndicator(context);

    String isShopping = await Services.customerIsShopping(
        state, city, store, address, storeUsername, customer);

    Services.hideLoadingIndicator(context);

    if (isShopping == "NOT SHOPPING\n") {
      String isInTemp = await Services.checkTempStorage(
          state, city, store, address, storeUsername, customer);

      if (isInTemp == "FOUND\n") {
        DateTime currentTime = DateTime.now();

        String currentHour = currentTime.hour.toString().padLeft(2, '0');
        String currentMinute = currentTime.minute.toString().padLeft(2, '0');

        String visitStartBlock = currentHour + currentMinute;
        String trueAdmittance = "True";

        String result = await Services.admitCustomer(state, city, store,
            address, storeUsername, customer, visitStartBlock, trueAdmittance);
        Services.showAlertMessage(info[0] + " Admitted!", result, context);
      } else {
        Services.showAlertMessage(info[0] + " Not Found",
            info[0] + " is not in the schedule.", context);
      }
    } else if (isShopping == "timed out") {
      Services.showAlertMessage(
          "Connection Error", "An error occurred, please try again.", context);
    } else {
      String storeCloseTime =
          storeController.getTextController("close_time").text;
      String maxCapacity = storeController.getTextController("capacity").text;

      String result = await Services.releaseCustomer(
          state,
          city,
          store,
          address,
          storeUsername,
          customer,
          isShopping,
          storeCloseTime,
          maxCapacity);
      Services.showAlertMessage(info[0] + " Released!", result, context);
    }
  }

  _onButtonPressed(BuildContext context, int option) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    switch (option) {
      case 1:
        {
          StoreProfileController result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreEdit(
                  storeProfile: storeController,
                ),
              ));

          if (result != null) {
            storeController = result;
            setState(() {
              _showSnackBar();
            });
          }
        }
        break;

    }
  }
}
