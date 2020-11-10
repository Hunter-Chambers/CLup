import 'package:flutter/material.dart';
import 'CustomerLogin.dart';
import 'CustomerProfileController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerEdit extends StatelessWidget {

  // build text editing controllers for each field
  final CustomerProfileController customerProfile;
  CustomerEdit({Key key, this.customerProfile}) : super (key: key);
  // = CustomerProfileController(["username", "password", "email", "phone"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Center(
        child: Container(
          color: Colors.white,
          width: 700,
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: customerProfile.getTextController("username"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username *",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: true,
                  controller: customerProfile.getTextController("password"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password *",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: customerProfile.getTextController("email"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email *",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: customerProfile.getTextController("phone"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone Number *",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: FloatingActionButton.extended(
                      heroTag: "SubmitBtn",
                      onPressed: () => _onButtonPressed(context, 1),
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
    Fluttertoast.showToast(
      msg: customerProfile.getTextController("username").text + ' ' +
      customerProfile.getTextController("password").text + ' ' +
      customerProfile.getTextController("email").text + ' ' + 
      customerProfile.getTextController("phone").text, 
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerLogin(customerProfile: customerProfile),
              ));
        }
    }
  }
}
