//import 'package:clup/SearchStoresView_Backup.dart';

import 'dart:html';

import 'package:clup/HomePage.dart';
import 'package:clup/StoreSearch/StoreSearch.dart';
import 'CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'CustomerEdit.dart';
import '../Schedule/ScheduleVisit.dart';
import '../Schedule/StoreScheduleController.dart';
import 'QR.dart';
import 'package:clup/Schedule/ScheduleVisit.dart';
import 'package:clup/main.dart';
import 'package:clup/CustomerProfile/CancelVisit.dart';

class CustomerLogin extends StatefulWidget {
  final StoreScheduleController scheduleController;
  final CustomerProfileController customerController;
  final String jwt;
  final Map<String, dynamic> payload;

  CustomerLogin({Key key, this.jwt, this.payload, this.customerController, this.scheduleController})
      : super(key: key);

  @override
  _CustomerLoginState createState() => _CustomerLoginState(
        jwt: jwt,
        payload: payload,
        customerController: customerController,
        scheduleController: scheduleController,
      );
}

class _CustomerLoginState extends State<CustomerLogin> {
  CustomerProfileController customerController;
  StoreScheduleController scheduleController;
  String jwt;
  Map<String, dynamic> payload;
  _CustomerLoginState({this.jwt, this.payload, this.customerController, this.scheduleController});

  @override
  Widget build(BuildContext context) {
    return /* WillPopScope(
      onWillPop: () async {
        customerController.reset();
        Navigator.pop(context);
        return false;
      },
      child: */ Scaffold(
        // color for the whole page
        backgroundColor: Color.fromARGB(100, 107, 255, 245),
        //appBar: AppBar(title: Text("To Previous Page")),

        body: SingleChildScrollView(
          child: 
            Container(
              height:MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              child:
              Center(
              child: Container(
                color: Colors.white,
                height: 700,
                width: 700,

                // holds all the info on the page
                child: ListView(
                  children: <Widget>[
                    // page title
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                      child: Text(
                        'Customer Profile Page',
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
                        'Username: ' +
                            customerController.getTextController('username').text +
                            '\n' +
                            'Email: ' +
                            customerController.getTextController('email').text +
                            '\n' +
                            'Phone Number: ' +
                            customerController.getTextController('phone').text +
                            '\n',
                        style: TextStyle(fontSize: 20),
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
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
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

                    // favorite a store button
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
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

                    // schedule a visit button
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
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

                    // QR code button
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
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
                    ),

                    // Cancel a visit
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
                      child: FloatingActionButton.extended(
                        heroTag: "canclBtn",
                        onPressed: () => _onButtonPressed(context, 5),
                        label: Text(
                          "Cancel a Visit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Signout button
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 0),
                      child: FloatingActionButton.extended(
                        heroTag: "CusSignOutBtn",
                        onPressed: () => _onButtonPressed(context, 6),
                        label: Text(
                          "Sign Out",
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

            ),
            
          ),
        
      //),
    );
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
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
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    switch (option) {
      case 1:
        {
          CustomerProfileController result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new CustomerEdit(
                  customerProfile: customerController,
                ),
              ));

          if (result != null) {
            customerController = result;
            setState(() {
              _showSnackBar('Updated changes successfully.');
            });
          }
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSearch(
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
                builder: (context) => QR(
                  customerProfile: customerController,
                ),
              ));
        }
        break;       
      case 5:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CancelVisit(customerProfile: customerController,),
              ));
        }
        break;       
      case 6:
        {
          /*
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebApp(),
              ));
          
          Navigator.popUntil(context, ModalRoute.withName('/'));

          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebApp(),
            )
          );
          */
          window.localStorage.remove('csrf');
          Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);

        }
        break;
        return null;
    }
  }
}
