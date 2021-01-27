import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:clup/StoreProfile/StoreProfileController.dart';
import 'package:clup/StoreProfile/StoreSignup.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'CustomerProfile/CustomerLogin.dart';
import 'CustomerProfile/CustomerSignup.dart';
import 'StoreProfile/StoreLogin.dart';
import 'StoreProfile/StoreSignup.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controllers to get text from username and password fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // holds user's username and password
  String username = "";
  String password = "";

  // profile controllers
  CustomerProfileController customerProfile = CustomerProfileController([
    "username",
    "password",
    "fname",
    "lname",
    "email",
    "phone",
  ]);
  StoreProfileController storeProfile = StoreProfileController([
    "username",
    "password",
    "open_time",
    "close_time",
    "capacity",
    "address",
    "city",
    "state",
    "zipcode",
  ]);

  // text to appear in the sign up button
  BoxShadow signupShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0.5,
    blurRadius: 5,
    offset: Offset(5, 5),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background for whole page
      backgroundColor: Color.fromARGB(100, 107, 255, 245),

      body: Center(
        // center white box
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,

          // putting the items in a listview allows for resizing
          // the window without receiving any errors
          child: ListView(
            children: <Widget>[
              // the title of the page
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // holds our text fields and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // holds the text fields in a column
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        // username field
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextField(
                            key: Key("userField"),
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                            ),
                          ),
                        ),

                        // password field
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            key: Key("passField"),
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Login button
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                    child: FloatingActionButton.extended(
                      heroTag: "LoginBtn",
                      onPressed: () {
                        _setUsername(_usernameController.text);
                        _setPassword(_passwordController.text);
                        _onButtonPressed(context, 3);
                      },
                      label: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.7,
                        ),
                      ),
                    ),
                  ),

                  // vertical divider
                  Container(
                    color: Color.fromARGB(255, 224, 224, 224),
                    width: 3,
                    height: 100,
                  ),

                  // holds the sign-up button
                  Container(
                    margin: EdgeInsets.only(left: 45),

                    // this gives the button the blue, rounded look
                    // as well as a shadow
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color.fromARGB(255, 33, 150, 243),
                      boxShadow: [signupShadow],
                    ),

                    // hide the tooltip that comes
                    // with the popup menu button
                    child: TooltipTheme(
                      data: TooltipThemeData(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),

                      // update the shadow when the
                      // mouse is over the button
                      child: MouseRegion(
                        onHover: (e) => _updateShadow(1),
                        onExit: (e) => _updateShadow(0),

                        // the actual signup button
                        child: PopupMenuButton(
                          tooltip: '',

                          // holds the signup text and icon
                          // that appear on the signup button
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // signup text
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 12, 10, 12),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.7,
                                  ),
                                ),
                              ),

                              // icon
                              Container(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // what happens when an item is selected
                          onSelected: (String value) {
                            setState(() {
                              if (value == "Customer") {
                                _onButtonPressed(context, 1);
                              } else {
                                _onButtonPressed(context, 2);
                              }
                            });
                          },

                          // list of items
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "Customer",
                              child: Text("Customer"),
                            ),
                            PopupMenuItem<String>(
                              value: "Store",
                              child: Text("Store"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // horizontal divider
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
              ),

              // description text
              Container(
                padding: EdgeInsets.fromLTRB(50, 35, 50, 52),
                child:
                    Text("A brief description about CLup will go here, along "
                        "with why CLup was developed."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // method for dynamically updating the signup
  // button's shadow when the mouse is over it
  _updateShadow(option) {
    if (option == 1) {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 10,
          offset: Offset(5, 5),
        );
      });
    } else {
      setState(() {
        signupShadow = BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 5,
          offset: Offset(5, 5),
        );
      });
    }
  }

  _setUsername(String input) {
    username = input;
  }

  _setPassword(String input) {
    password = input;
  }

  _onButtonPressed(BuildContext context, int option) {
    String customerUsername = 'customer';
    String customerPassword = 'password00';

    String storeUsername = 'store';
    String storePassword = 'password00';

    switch (option) {
      case 1:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSignup(),
              ));
        }
        break;
      case 2:
        {
          return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreSignup(),
              ));
        }
        break;
      case 3:
        {
          if (username != customerUsername && username != storeUsername) {
            Fluttertoast.showToast(
              msg: 'Username did not match any users.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          } else if (password != customerPassword &&
              password != storePassword) {
            Fluttertoast.showToast(
              msg: 'Password was incorrect.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          } else if (username == customerUsername) {
            customerProfile.getTextController("username").text =
                _usernameController.text;
            customerProfile.getTextController("password").text =
                _passwordController.text;
            customerProfile.getTextController("fname").text = "FirstName";
            customerProfile.getTextController("lname").text = "LastName";
            customerProfile.getTextController("email").text =
                "random@email.com";
            customerProfile.getTextController("phone").text =
                "(123) 456 - 7890";
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerLogin(
                    customerController: customerProfile,
                  ),
                ));
          } else {
            storeProfile.getTextController("username").text =
                _usernameController.text;
            storeProfile.getTextController("password").text =
                _passwordController.text;
            storeProfile.getTextController("open_time").text = "7:00AM";
            storeProfile.getTextController("close_time").text = "11:00PM";
            storeProfile.getTextController("capacity").text = "1500";
            storeProfile.getTextController("address").text =
                "1234 Random Street";
            storeProfile.getTextController("city").text = "Amarillo";
            storeProfile.getTextController("state").text = "TX";
            storeProfile.getTextController("zipcode").text = "79124";
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreLogin(
                    storeController: storeProfile,
                  ),
                ));
          }
        }
        break;
        return null;
    }
  }
}
