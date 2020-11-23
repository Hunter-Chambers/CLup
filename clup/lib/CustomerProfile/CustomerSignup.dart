import 'package:flutter/material.dart';
import 'CustomerLogin.dart';
import 'CustomerProfileController.dart';

class CustomerSignup extends StatelessWidget {
  // specify fields for text editing controllers
  final CustomerProfileController customerProfile = CustomerProfileController([
    "username",
    "password",
    "email",
    "phone",
  ]);

  // helps validate the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color for whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("This is the Customer signup page")),

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
                        controller:
                            customerProfile.getTextController("username"),
                        validator: (String value) {
                          if (value.length < 5 || value.length > 15) {
                            return "Must be 5-15 characters";
                          }
                          if (value.contains(
                              new RegExp(r'[\\/%&*()=\[\]{}":;\.,<>? ]'))) {
                            return "Must not contain \\/%&*()=[]{}\":;.,<>? or spaces";
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
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
                        controller:
                            customerProfile.getTextController("password"),
                        obscureText: true,
                        validator: (String value) {
                          if (value.length < 10) {
                            return "Must be at least 10 characters";
                          }
                          if (value.contains(
                              new RegExp(r'[\\/%&*()=\[\]{}":;\.,<>? ]'))) {
                            return "Must not contain \\/%&*()=[]{}\":;.,<>? or spaces";
                          }
                          if (value.contains(customerProfile
                              .getTextController("username")
                              .text)) {
                            return "Must not contain the username";
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
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
                          if (!value.contains(customerProfile
                                  .getTextController("password")
                                  .text) ||
                              value.length <= 0) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Retype Password *",
                        ),
                      ),
                    ),

                    // email field
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: customerProfile.getTextController("email"),
                        validator: (String value) {
                          if (!value.contains(new RegExp(r'.+@.+\..+'))) {
                            return "Must be a valid email address";
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email *",
                        ),
                      ),
                    ),

                    // phone field
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: customerProfile.getTextController("phone"),
                        validator: (String value) {
                          if (!(value.contains(new RegExp(
                                  r'\([0-9][0-9][0-9]\) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')) ||
                              value.contains(new RegExp(
                                  r'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')))) {
                            return "Must contain a valid phone number";
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number *",
                        ),
                      ),
                    ),

                    // holds the submit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // submit button
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
                builder: (context) =>
                    CustomerLogin(customerController: customerProfile),
              ));
        }
    }
  }
}
