import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:flutter/material.dart';
import 'StoreEdit.dart';
import 'ScanQR.dart';

class StoreLogin extends StatefulWidget {
  final StoreProfileController storeController;
  StoreLogin({Key key, this.storeController}) : super(key: key);

  @override
  _StoreLoginState createState() => _StoreLoginState(
        storeController: storeController,
      );
}

class _StoreLoginState extends State<StoreLogin> {
  StoreProfileController storeController;
  _StoreLoginState({this.storeController});

  // call scaffoldKey in order to show snackbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

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
                  onPressed: () => _onButtonPressed(context, 2),
                  label: Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(
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

  _onButtonPressed(BuildContext context, int option) async {
    _scaffoldKey.currentState.removeCurrentSnackBar();
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
      case 2:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanQR(),
              ));
        }
        break;
    }
  }
}
