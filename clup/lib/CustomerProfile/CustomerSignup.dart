import 'package:clup/testing/Services.dart';
import 'package:flutter/material.dart';
import 'CustomerProfileController.dart';

class CustomerSignup extends StatelessWidget {
  final Services services;
  final CustomerProfileController customerProfile;

  // helps validate the form
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController passwordController = new TextEditingController();

  CustomerSignup({Key key, this.services, this.customerProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        customerProfile.reset();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
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
                      // username field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          key: Key("usernameField"),
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
                          key: Key("passwordField"),
                          controller: passwordController,
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
                          key: Key("passCheckField"),
                          obscureText: true,
                          validator: (String value) {
                            if (!value.contains(
                                  new RegExp(
                                      r'^' + passwordController.text + r'$'),
                                ) ||
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

                      // first name field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          key: Key("fnameField"),
                          controller:
                              customerProfile.getTextController("fname"),
                          validator: (String value) {
                            if (!value.contains(new RegExp(r"[a-zA-Z'-]"))) {
                              return "Must only contain ' - and letters.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "First Name *",
                          ),
                        ),
                      ),

                      // last name field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          key: Key("lnameField"),
                          controller:
                              customerProfile.getTextController("lname"),
                          validator: (String value) {
                            if (!value
                                .contains(new RegExp(r"^([ a-zA-Z'-])+$"))) {
                              return "Must only contain ' - and letters.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Last Name *",
                          ),
                        ),
                      ),

                      // email field
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          key: Key("emailField"),
                          controller:
                              customerProfile.getTextController("email"),
                          validator: (String value) {
                            if (!value.contains(new RegExp(r'.+@.+\..+'))) {
                              return "Must be a valid email address";
                            }
                            return null;
                          },
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
                          key: Key("phoneField"),
                          controller:
                              customerProfile.getTextController("phone"),
                          validator: (String value) {
                            if (!(value.contains(new RegExp(
                                r'^\({0,1}[0-9][0-9][0-9]\){0,1}[ -]{0,1}[0-9][0-9][0-9] {0,1}-{0,1} {0,1}[0-9][0-9][0-9][0-9]$')))) {
                              return "Must contain a valid phone number";
                            }
                            return null;
                          },
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
                              key: Key("submitBtnCustomer"),
                              heroTag: "SubmitBtn",
                              onPressed: () async {
                                if (services.runtimeType != Services ||
                                    _formKey.currentState.validate()) {
                                  Services.showLoadingIndicator(context);

                                  customerProfile.formatPhoneNumber();

                                  Map<String, dynamic> map = {
                                    "username": customerProfile
                                        .getTextController("username")
                                        .text,
                                    "password": passwordController.text,
                                    "fname": customerProfile
                                        .getTextController("fname")
                                        .text,
                                    "lname": customerProfile
                                        .getTextController("lname")
                                        .text,
                                    "email": customerProfile
                                        .getTextController("email")
                                        .text,
                                    "phone": customerProfile
                                        .getTextController("phone")
                                        .text
                                  };

                                  String result = await services.addProfile(
                                      map, CustomerSignup);

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
          customerProfile.reset();
          Navigator.pop(context);
          return Services.showAlertMessage("Profile Successfully Created",
              "Your profile was created!\nPlease log in.", context);
        }
    }
  }
}
