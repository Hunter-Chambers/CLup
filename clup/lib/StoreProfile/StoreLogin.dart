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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  'Store Login Page',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
              Container(
                  alignment: Alignment.center,
                  child: Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                  )),
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
    _scaffoldKey.currentState?.showSnackBar(
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
    switch (option) {
      case 1:
        {
          storeController = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreEdit(
                  storeProfile: storeController,
                ),
              ));

          setState(() {
            _showSnackBar();
          });
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
