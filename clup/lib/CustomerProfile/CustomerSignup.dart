import 'package:flutter/material.dart';
import 'CustomerLogin.dart';
import 'CustomerProfileController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerSignup extends StatelessWidget {

  // specify fields for text editing controllers
  final CustomerProfileController customerProfile = CustomerProfileController(["username", "password", "email", "phone"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("This is the Customer signup page")),
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
                  controller: customerProfile.getTextController("password"),
                  obscureText: true,
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
    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerLogin(customerController: customerProfile),
              ));
        }
    }
  }
}
