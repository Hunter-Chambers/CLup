//import 'package:clup/SearchStoresView_Backup.dart';
import 'package:clup/StoreSearch/StatesView.dart';
import 'CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'CustomerEdit.dart';
import '../Schedule/ScheduleVisit.dart';
import 'QR.dart';

class CustomerLogin extends StatefulWidget {
  final CustomerProfileController customerController;
  final int snackFlag;
  CustomerLogin({Key key, this.customerController, this.snackFlag = 0})
      : super(key: key);

  @override
  _CustomerLoginState createState() => _CustomerLoginState(
        customerController: customerController,
        snackFlag: snackFlag,
      );
}

class _CustomerLoginState extends State<CustomerLogin> {
  final CustomerProfileController customerController;
  final int snackFlag;
  _CustomerLoginState({this.customerController, this.snackFlag});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (snackFlag == 1) {
      WidgetsBinding.instance
          .addPostFrameCallback((timeStamp) => _showSnackBar());
    }
  }

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
                  'Customer Login Page',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Username: ' +
                        customerController.getTextController('username').text +
                        '\n' +
                        'Email: ' +
                        customerController.getTextController('email').text +
                        '\n' +
                        'Phone Number: ' +
                        customerController.getTextController('phone').text +
                        '\n',
                  )),
              Container(
                  alignment: Alignment.center,
                  child: Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(150, 15, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "EditBtn",
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
                padding: EdgeInsets.fromLTRB(150, 15, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "FavoriteBtn",
                  onPressed: () => _onButtonPressed(context, 2),
                  label: Text(
                    "Favorite a Store",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 15, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "ScheduleBtn",
                  onPressed: () => _onButtonPressed(context, 3),
                  label: Text(
                    "Schedule a visit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 15, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "QRBtn",
                  onPressed: () => _onButtonPressed(context, 4),
                  label: Text(
                    "QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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

  _onButtonPressed(BuildContext context, int option) {
    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new CustomerEdit(
                  customerProfile: customerController,
                ),
              ));
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatesView(
                  customerController: customerController,
                ),
              ));
        }
        break;
      case 3:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScheduleVisit(
                  customerController: customerController,
                ),
              ));
        }
        break;
      case 4:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QR(),
              ));
        }
        break;
        return null;
    }
  }
}
